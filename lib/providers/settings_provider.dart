import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/feature_models.dart';

class SettingsProvider with ChangeNotifier {
  UserSettings _settings = UserSettings();

  UserSettings get settings => _settings;

  // Initialize settings from shared preferences
  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsData = prefs.getString('user_settings');

      if (settingsData != null) {
        final Map<String, dynamic> decoded = json.decode(settingsData);
        _settings = UserSettings.fromMap(decoded);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading settings: $e');
      // Keep default settings on error
    }
  }

  // Save settings to shared preferences
  Future<void> saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = json.encode(_settings.toMap());
      await prefs.setString('user_settings', encoded);
    } catch (e) {
      print('Error saving settings: $e');
    }
  }

  // Update language
  void setLanguage(String language) {
    _settings = _settings.copyWith(language: language);
    saveSettings();
    notifyListeners();
  }

  // Toggle notifications
  void toggleNotifications(bool value) {
    _settings = _settings.copyWith(notificationsEnabled: value);
    saveSettings();
    notifyListeners();
  }

  // Toggle dark mode
  void toggleDarkMode(bool value) {
    _settings = _settings.copyWith(darkModeEnabled: value);
    saveSettings();
    notifyListeners();
  }

  // Set weight unit
  void setWeightUnit(String unit) {
    if (unit == 'kg' || unit == 'lb') {
      _settings = _settings.copyWith(weightUnit: unit);
      saveSettings();
      notifyListeners();
    }
  }

  // Update preferred categories
  void updatePreferredCategories(List<String> categories) {
    _settings = _settings.copyWith(preferredCategories: categories);
    saveSettings();
    notifyListeners();
  }

  // Convert weight between units
  double convertWeight(double weight, String fromUnit, String toUnit) {
    if (fromUnit == toUnit) return weight;

    if (fromUnit == 'kg' && toUnit == 'lb') {
      return weight * 2.20462;
    } else if (fromUnit == 'lb' && toUnit == 'kg') {
      return weight / 2.20462;
    }

    return weight;
  }

  // Get current weight based on settings
  double formatWeight(double weightInKg) {
    if (_settings.weightUnit == 'kg') {
      return double.parse(weightInKg.toStringAsFixed(1));
    } else {
      return double.parse((weightInKg * 2.20462).toStringAsFixed(1));
    }
  }

  // Get weight unit display string
  String get weightUnitDisplay => _settings.weightUnit;
}