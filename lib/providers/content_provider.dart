//providers/content_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/content_model.dart';
import '../utils/sample_data.dart';

class ContentProvider extends ChangeNotifier {
  ContentData? _contentData;
  bool _isLoading = true;
  List<String> _favorites = [];
  final _searchResults = <ContentQuestion>[];
  List<ContentCategory> get categories => _contentData?.categories ?? [];


  ContentData? get contentData => _contentData;
  bool get isLoading => _isLoading;
  List<String> get favorites => _favorites;
  List<ContentQuestion> get searchResults => _searchResults;

  ContentProvider() {
    _loadContent();
    _loadFavorites();
  }

  Future<void> _loadContent() async {
    _isLoading = true;
    notifyListeners();

    try {
      // First try to load from Hive (for offline support)
      final contentBox = Hive.box('content');
      final savedContent = contentBox.get('contentData');

      if (savedContent != null) {
        final Map<String, dynamic> jsonData = json.decode(savedContent);
        _contentData = ContentData.fromJson(jsonData);
      } else {
        // If no saved content, load from assets or use sample data
        try {
          final String jsonString = await rootBundle.loadString('assets/data/content.json');
          final Map<String, dynamic> jsonData = json.decode(jsonString);
          _contentData = ContentData.fromJson(jsonData);
        } catch (e) {
          // Fallback to sample data
          _contentData = SampleData.getSampleContent();
        }

        // Save to Hive for offline access
        await contentBox.put('contentData', json.encode(_contentData?.toJson()));
      }
    } catch (e) {
      debugPrint('Error loading content: $e');
      // Fallback to sample data
      _contentData = SampleData.getSampleContent();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    final favoritesBox = Hive.box('favorites');
    final savedFavorites = favoritesBox.get('userFavorites');

    if (savedFavorites != null) {
      _favorites = List<String>.from(savedFavorites);
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String questionId) async {
    if (_favorites.contains(questionId)) {
      _favorites.remove(questionId);
    } else {
      _favorites.add(questionId);
    }

    final favoritesBox = Hive.box('favorites');
    await favoritesBox.put('userFavorites', _favorites);

    notifyListeners();
  }

  bool isFavorite(String questionId) {
    return _favorites.contains(questionId);
  }

  List<ContentQuestion> getFavoriteQuestions() {
    final List<ContentQuestion> favoriteQuestions = [];

    if (_contentData == null) return [];

    for (final category in _contentData!.categories) {
      for (final question in category.questions) {
        if (_favorites.contains(question.id)) {
          favoriteQuestions.add(question);
        }
      }
    }

    return favoriteQuestions;
  }

  void searchContent(String query) {
    if (query.isEmpty) {
      _searchResults.clear();
      notifyListeners();
      return;
    }

    final queryLower = query.toLowerCase();
    final results = <ContentQuestion>[];

    if (_contentData == null) return;

    for (final category in _contentData!.categories) {
      for (final question in category.questions) {
        if (question.question.toLowerCase().contains(queryLower) ||
            question.answer.toLowerCase().contains(queryLower)) {
          results.add(question);
        }
      }
    }

    _searchResults.clear();
    _searchResults.addAll(results);
    notifyListeners();
  }

  ContentCategory? getCategoryById(String categoryId) {
    if (_contentData == null) return null;

    try {
      return _contentData!.categories.firstWhere((cat) => cat.id == categoryId);
    } catch (e) {
      return null;
    }
  }

  ContentQuestion? getQuestionById(String questionId) {
    if (_contentData == null) return null;

    for (final category in _contentData!.categories) {
      try {
        final question = category.questions.firstWhere((q) => q.id == questionId);
        return question;
      } catch (e) {
        // Question not found in this category, continue to next
        continue;
      }
    }

    return null;
  }
}