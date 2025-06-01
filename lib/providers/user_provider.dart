// providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class KickSession {
  final int count;
  final DateTime date;
  final Duration duration;

  KickSession({
    required this.count,
    required this.date,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'date': date.toIso8601String(),
      'duration': duration.inSeconds,
    };
  }

  factory KickSession.fromJson(Map<String, dynamic> json) {
    return KickSession(
      count: json['count'],
      date: DateTime.parse(json['date']),
      duration: Duration(seconds: json['duration']),
    );
  }
}

class WeightEntry {
  final DateTime date;
  final double weight;

  WeightEntry({
    required this.date,
    required this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'weight': weight,
    };
  }

  factory WeightEntry.fromJson(Map<String, dynamic> json) {
    return WeightEntry(
      date: DateTime.parse(json['date']),
      weight: json['weight'],
    );
  }
}

class PregnancyNote {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;

  PregnancyNote({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory PregnancyNote.fromJson(Map<String, dynamic> json) {
    return PregnancyNote(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  PregnancyNote copyWith({
    String? title,
    String? content,
    String? category,
    DateTime? updatedAt,
  }) {
    return PregnancyNote(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserProvider extends ChangeNotifier {
  DateTime? _dueDate;
  DateTime? _lastPeriodDate;
  bool _isFirstLaunch = true;
  String _preferredLanguage = 'en';
  bool _notificationsEnabled = true;
  final List<KickSession> _kickSessions = [];
  final List<WeightEntry> _weightEntries = [];
  final List<PregnancyNote> _pregnancyNotes = [];
  List<String> _enabledToolIds = ['dueDate', 'kickCounter', 'weightTracker', 'nutrition'];

  DateTime? get dueDate => _dueDate;
  DateTime? get lastPeriodDate => _lastPeriodDate;
  bool get isFirstLaunch => _isFirstLaunch;
  String get preferredLanguage => _preferredLanguage;
  List<KickSession> get kickSessions => _kickSessions;
  List<WeightEntry> get weightEntries => _weightEntries;
  List<PregnancyNote> get pregnancyNotes => List.unmodifiable(_pregnancyNotes);
  List<String> get enabledToolIds => List.unmodifiable(_enabledToolIds);

  bool _useCelsius = true;
  bool get useCelsius => _useCelsius;
  set useCelsius(bool value) {
    _useCelsius = value;
    Hive.box('appSettings').put('useCelsius', value);
    notifyListeners();
  }

  String get language => _preferredLanguage;
  set language(String value) {
    _preferredLanguage = value;
    Hive.box('appSettings').put('preferredLanguage', value);
    notifyListeners();
  }

  String _region = 'int'; // Standardwert "International"
  String get region => _region;
  set region(String value) {
    _region = value;
    Hive.box('appSettings').put('region', value);
    notifyListeners();
  }

  bool get notificationsEnabled => _notificationsEnabled;
  set notificationsEnabled(bool value) {
    _notificationsEnabled = value;
    Hive.box('appSettings').put('notificationsEnabled', value);
    notifyListeners();
  }

  UserProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final settingsBox = Hive.box('appSettings');

    try {
      // Lade allgemeine Einstellungen
      final savedDueDate = settingsBox.get('dueDate');
      final savedLastPeriodDate = settingsBox.get('lastPeriodDate');
      final savedFirstLaunch = settingsBox.get('isFirstLaunch');
      final savedLanguage = settingsBox.get('preferredLanguage');
      final savedNotifications = settingsBox.get('notificationsEnabled');
      final savedRegion = settingsBox.get('region');
      final savedUseCelsius = settingsBox.get('useCelsius');
      final savedEnabledTools = settingsBox.get('enabledToolIds');

      if (savedDueDate != null) {
        _dueDate = DateTime.parse(savedDueDate);
      }

      if (savedLastPeriodDate != null) {
        _lastPeriodDate = DateTime.parse(savedLastPeriodDate);
      }

      if (savedFirstLaunch != null) {
        _isFirstLaunch = savedFirstLaunch;
      }

      if (savedLanguage != null) {
        _preferredLanguage = savedLanguage;
      }

      if (savedNotifications != null) {
        _notificationsEnabled = savedNotifications;
      }

      if (savedRegion != null) {
        _region = savedRegion;
      }

      if (savedUseCelsius != null) {
        _useCelsius = savedUseCelsius;
      }

      if (savedEnabledTools != null) {
        _enabledToolIds = List<String>.from(savedEnabledTools);
      }

      // Lade Kick Counter Daten
      final savedKickSessions = settingsBox.get('kickSessions');
      if (savedKickSessions != null) {
        final List<dynamic> sessionsList = savedKickSessions;
        _kickSessions.clear();
        for (var sessionData in sessionsList) {
          _kickSessions.add(KickSession.fromJson(Map<String, dynamic>.from(sessionData)));
        }
      }

      // Lade Weight Tracker Daten
      final savedWeightEntries = settingsBox.get('weightEntries');
      if (savedWeightEntries != null) {
        final List<dynamic> entriesList = savedWeightEntries;
        _weightEntries.clear();
        for (var entryData in entriesList) {
          _weightEntries.add(WeightEntry.fromJson(Map<String, dynamic>.from(entryData)));
        }
      }

      // Lade Pregnancy Notes
      final savedNotes = settingsBox.get('pregnancyNotes');
      if (savedNotes != null) {
        final List<dynamic> notesList = savedNotes;
        _pregnancyNotes.clear();
        for (var noteData in notesList) {
          _pregnancyNotes.add(PregnancyNote.fromJson(Map<String, dynamic>.from(noteData)));
        }
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }

    notifyListeners();
  }

  Future<void> setDueDate(DateTime dueDate) async {
    _dueDate = dueDate;

    // Auch das Datum der letzten Periode setzen
    _lastPeriodDate = dueDate.subtract(const Duration(days: 280));

    final settingsBox = Hive.box('appSettings');
    await settingsBox.put('dueDate', dueDate.toIso8601String());
    await settingsBox.put('lastPeriodDate', _lastPeriodDate!.toIso8601String());

    notifyListeners();
  }

  Future<void> setLastPeriodDate(DateTime lastPeriodDate) async {
    _lastPeriodDate = lastPeriodDate;

    final settingsBox = Hive.box('appSettings');
    await settingsBox.put('lastPeriodDate', lastPeriodDate.toIso8601String());

    notifyListeners();
  }

  Future<void> setFirstLaunchComplete() async {
    _isFirstLaunch = false;

    final settingsBox = Hive.box('appSettings');
    await settingsBox.put('isFirstLaunch', false);

    notifyListeners();
  }

  Future<void> setPreferredLanguage(String language) async {
    _preferredLanguage = language;

    final settingsBox = Hive.box('appSettings');
    await settingsBox.put('preferredLanguage', language);

    notifyListeners();
  }

  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;

    final settingsBox = Hive.box('appSettings');
    await settingsBox.put('notificationsEnabled', _notificationsEnabled);

    notifyListeners();
  }

  int get weeksPregnant {
    if (_dueDate == null) return 0;

    final today = DateTime.now();
    final difference = _dueDate!.difference(today);

    // Pregnancy is about 40 weeks
    final daysLeft = difference.inDays;
    final weeksLeft = daysLeft ~/ 7;

    return 40 - weeksLeft;
  }

  int get daysLeft {
    if (_dueDate == null) return 0;

    final today = DateTime.now();
    final difference = _dueDate!.difference(today);

    return difference.inDays;
  }

  // Methoden für KickCounter
  void addKickSession(KickSession session) {
    _kickSessions.insert(0, session);  // Insert at the beginning for reverse chronological order
    _saveKickSessions();
    notifyListeners();
  }

  void removeKickSession(int index) {
    if (index >= 0 && index < _kickSessions.length) {
      _kickSessions.removeAt(index);
      _saveKickSessions();
      notifyListeners();
    }
  }

  Future<void> _saveKickSessions() async {
    try {
      final settingsBox = Hive.box('appSettings');
      List<Map<String, dynamic>> sessionsList = _kickSessions.map((session) => session.toJson()).toList();
      await settingsBox.put('kickSessions', sessionsList);
    } catch (e) {
      debugPrint('Error saving kick sessions: $e');
    }
  }

  // Methoden für WeightTracker
  void addWeightEntry({required DateTime date, required double weight}) {
    _weightEntries.add(WeightEntry(date: date, weight: weight));
    _saveWeightEntries();
    notifyListeners();
  }

  void removeWeightEntry(WeightEntry entry) {
    _weightEntries.remove(entry);
    _saveWeightEntries();
    notifyListeners();
  }

  Future<void> _saveWeightEntries() async {
    try {
      final settingsBox = Hive.box('appSettings');
      List<Map<String, dynamic>> entriesList = _weightEntries.map((entry) => entry.toJson()).toList();
      await settingsBox.put('weightEntries', entriesList);
    } catch (e) {
      debugPrint('Error saving weight entries: $e');
    }
  }

  // Methoden für Pregnancy Notes
  void addNote({
    required String title,
    required String content,
    required String category,
  }) {
    final note = PregnancyNote(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      category: category,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _pregnancyNotes.insert(0, note); // Insert at the beginning for latest first
    _saveNotes();
    notifyListeners();
  }

  void updateNote(
      PregnancyNote note, {
        required String title,
        required String content,
        required String category,
      }) {
    final index = _pregnancyNotes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      final updatedNote = note.copyWith(
        title: title,
        content: content,
        category: category,
        updatedAt: DateTime.now(),
      );
      _pregnancyNotes[index] = updatedNote;
      _saveNotes();
      notifyListeners();
    }
  }

  void removeNote(PregnancyNote note) {
    _pregnancyNotes.removeWhere((n) => n.id == note.id);
    _saveNotes();
    notifyListeners();
  }

  Future<void> _saveNotes() async {
    try {
      final settingsBox = Hive.box('appSettings');
      List<Map<String, dynamic>> notesList = _pregnancyNotes.map((note) => note.toJson()).toList();
      await settingsBox.put('pregnancyNotes', notesList);
    } catch (e) {
      debugPrint('Error saving pregnancy notes: $e');
    }
  }

  // Methoden für Tool-Personalisierung
  void updateEnabledTools(List<String> toolIds) {
    _enabledToolIds = List.from(toolIds);
    _saveEnabledTools();
    notifyListeners();
  }

  void enableTool(String toolId) {
    if (!_enabledToolIds.contains(toolId)) {
      _enabledToolIds.add(toolId);
      _saveEnabledTools();
      notifyListeners();
    }
  }

  void disableTool(String toolId) {
    if (_enabledToolIds.contains(toolId)) {
      _enabledToolIds.remove(toolId);
      _saveEnabledTools();
      notifyListeners();
    }
  }

  Future<void> _saveEnabledTools() async {
    try {
      final settingsBox = Hive.box('appSettings');
      await settingsBox.put('enabledToolIds', _enabledToolIds);
    } catch (e) {
      debugPrint('Error saving enabled tools: $e');
    }
  }
}