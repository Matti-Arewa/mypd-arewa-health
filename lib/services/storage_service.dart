//services/storage_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/content_model.dart';
import '../providers/user_provider.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  // Keys for storage
  static const String _categoriesKey = 'categories';
  static const String _favoritesKey = 'favorites';
  static const String _dueDateKey = 'due_date';
  static const String _lastUpdatedKey = 'last_updated';
  static const String _kickCounterHistoryKey = 'kick_counter_history';
  static const String _weightHistoryKey = 'weight_history';

  // Save categories to local storage
  Future<void> saveCategories(List<ContentCategory> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = json.encode(
      categories.map((category) => category.toJson()).toList(),
    );
    await prefs.setString(_categoriesKey, encodedData);
    await prefs.setString(_lastUpdatedKey, DateTime.now().toIso8601String());
  }

  // Load categories from local storage
  Future<List<ContentCategory>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = prefs.getString(_categoriesKey);

    if (encodedData == null) {
      return [];
    }

    final List<dynamic> decodedData = json.decode(encodedData);
    return decodedData
        .map((categoryData) => ContentCategory.fromJson(categoryData))
        .toList();
  }

  // Save favorites
  Future<void> saveFavorites(List<String> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, favoriteIds);
  }

  // Load favorites
  Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  // Save due date
  Future<void> saveDueDate(DateTime dueDate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dueDateKey, dueDate.toIso8601String());
  }

  // Load due date
  Future<DateTime?> loadDueDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dueDateString = prefs.getString(_dueDateKey);

    if (dueDateString == null) {
      return null;
    }

    return DateTime.parse(dueDateString);
  }

  // Save kick counter history
  Future<void> saveKickCounterHistory(List<KickSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = json.encode(
      sessions.map((session) => session.toJson()).toList(),
    );
    await prefs.setString(_kickCounterHistoryKey, encodedData);
  }

  // Load kick counter history
  Future<List<KickSession>> loadKickCounterHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = prefs.getString(_kickCounterHistoryKey);

    if (encodedData == null) {
      return [];
    }

    final List<dynamic> decodedData = json.decode(encodedData);
    return decodedData
        .map((sessionData) => KickSession.fromJson(sessionData))
        .toList();
  }

  // Save weight history
  Future<void> saveWeightHistory(List<WeightEntry> records) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = json.encode(
      records.map((record) => record.toJson()).toList(),
    );
    await prefs.setString(_weightHistoryKey, encodedData);
  }

  // Load weight history
  Future<List<WeightEntry>> loadWeightHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = prefs.getString(_weightHistoryKey);

    if (encodedData == null) {
      return [];
    }

    final List<dynamic> decodedData = json.decode(encodedData);
    return decodedData
        .map((recordData) => WeightEntry.fromJson(recordData))
        .toList();
  }

  // Get last update time
  Future<DateTime?> getLastUpdated() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdatedString = prefs.getString(_lastUpdatedKey);

    if (lastUpdatedString == null) {
      return null;
    }

    return DateTime.parse(lastUpdatedString);
  }

  // Clear all data (for debugging or reset)
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}