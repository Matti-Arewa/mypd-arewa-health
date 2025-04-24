import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/content_model.dart';
import '../utils/sample_data_en.dart';
import '../utils/sample_data_de.dart';
import 'package:flutter/foundation.dart';

class ContentProvider extends ChangeNotifier {
  ContentData? _contentData;
  bool _isLoading = true;
  List<String> _favorites = [];
  final _searchResults = <ContentQuestion>[];
  String _language = 'en';  // Default language is English

  ContentData? get contentData => _contentData;
  bool get isLoading => _isLoading;
  List<String> get favorites => _favorites;
  List<ContentQuestion> get searchResults => _searchResults;
  List<ContentSection> get sections => _contentData?.sections ?? [];

  // Getter for backward compatibility
  List<ContentCategory> get categories {
    List<ContentCategory> allCategories = [];
    for (final section in sections) {
      allCategories.addAll(section.categories);
    }
    return allCategories;
  }

  ContentProvider() {
    _loadContent();
    _loadFavorites();
  }

  Future<void> updateLanguage(String language) async {
    if (_language != language) {
      if (kDebugMode) {
        print("ContentProvider: Updating language to $language");
      }

      _language = language;

      // Verwende Future.microtask, um den Aufruf zu verzögern,
      // bis der aktuelle Build-Prozess abgeschlossen ist
      Future.microtask(() async {
        await _loadContent();
      });
    }
  }

  Future<void> _loadContent() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (kDebugMode) {
        print("ContentProvider: Loading content for language: $_language");
      }

      // First try to load from Hive (for offline support)
      final contentBox = Hive.box('content');
      final saveKey = 'contentData_$_language';
      final savedContent = contentBox.get(saveKey);

      if (savedContent != null) {
        if (kDebugMode) {
          print("ContentProvider: Found saved content in Hive");
        }

        final Map<String, dynamic> jsonData = json.decode(savedContent);
        _contentData = ContentData.fromJson(jsonData);
      } else {
        // Use sample data directly instead of trying to load from assets
        if (kDebugMode) {
          print("ContentProvider: Using sample data");
        }

        // Load appropriate sample data based on language
        if (_language == 'en') {
          _contentData = SampleDataEN.getSampleContent();
        } else if (_language == 'de') {
          _contentData = SampleData.getSampleContent();
        } else {
          // Default to English data if no match is found
          _contentData = SampleDataEN.getSampleContent();
        }

        // Save to Hive for offline access
        await contentBox.put(saveKey, json.encode(_contentData?.toJson()));
      }
    } catch (e) {
      debugPrint('Error loading content: $e');
      // Fallback to sample data based on language
      if (_language == 'en') {
        _contentData = SampleDataEN.getSampleContent();
      } else if (_language == 'de') {
        _contentData = SampleData.getSampleContent();
      } else {
        // Default to English data if no match is found
        _contentData = SampleDataEN.getSampleContent();
      }
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

    for (final section in _contentData!.sections) {
      for (final category in section.categories) {
        for (final question in category.questions) {
          if (_favorites.contains(question.id)) {
            favoriteQuestions.add(question);
          }
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

    for (final section in _contentData!.sections) {
      for (final category in section.categories) {
        for (final question in category.questions) {
          if (question.question.toLowerCase().contains(queryLower) ||
              question.answer.toLowerCase().contains(queryLower)) {
            results.add(question);
          }
        }
      }
    }

    _searchResults.clear();
    _searchResults.addAll(results);
    notifyListeners();
  }

  ContentSection? getSectionById(String sectionId) {
    if (_contentData == null) return null;

    try {
      return _contentData!.sections.firstWhere((section) => section.id == sectionId);
    } catch (e) {
      if (kDebugMode) {
        print("ContentProvider: Section not found: $sectionId");
      }
      return null;
    }
  }

  ContentCategory? getCategoryById(String categoryId) {
    if (_contentData == null) return null;

    for (final section in _contentData!.sections) {
      try {
        return section.categories.firstWhere((cat) => cat.id == categoryId);
      } catch (e) {
        // Category not found in this section, continue to next
        continue;
      }
    }

    if (kDebugMode) {
      print("ContentProvider: Category not found: $categoryId");
    }
    return null;
  }

  ContentQuestion? getQuestionById(String questionId) {
    if (_contentData == null) return null;

    for (final section in _contentData!.sections) {
      for (final category in section.categories) {
        try {
          final question = category.questions.firstWhere((q) => q.id == questionId);
          return question;
        } catch (e) {
          // Question not found in this category, continue to next
          continue;
        }
      }
    }

    if (kDebugMode) {
      print("ContentProvider: Question not found: $questionId");
    }
    return null;
  }
}