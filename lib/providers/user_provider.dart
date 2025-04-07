//providers/user_provider.dart
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

class UserProvider extends ChangeNotifier {
  DateTime? _dueDate;
  DateTime? _lastPeriodDate;
  bool _isFirstLaunch = true;
  String _preferredLanguage = 'de';
  bool _notificationsEnabled = true;
  final List<KickSession> _kickSessions = [];

  DateTime? get dueDate => _dueDate;
  DateTime? get lastPeriodDate => _lastPeriodDate;
  bool get isFirstLaunch => _isFirstLaunch;
  String get preferredLanguage => _preferredLanguage;
  List<KickSession> get kickSessions => _kickSessions;

  final List<WeightEntry> _weightEntries = [];
  List<WeightEntry> get weightEntries => _weightEntries;

  // Dark Mode wurde entfernt

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

    final savedDueDate = settingsBox.get('dueDate');
    final savedLastPeriodDate = settingsBox.get('lastPeriodDate');
    final savedFirstLaunch = settingsBox.get('isFirstLaunch');
    final savedLanguage = settingsBox.get('preferredLanguage');
    final savedNotifications = settingsBox.get('notificationsEnabled');
    // Dark Mode Einstellung wurde entfernt
    final savedRegion = settingsBox.get('region');
    final savedUseCelsius = settingsBox.get('useCelsius');

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

    // Dark Mode Laden wurde entfernt

    if (savedRegion != null) {
      _region = savedRegion;
    }

    if (savedUseCelsius != null) {
      _useCelsius = savedUseCelsius;
    }

    notifyListeners();
  }

  Future<void> setDueDate(DateTime dueDate) async {
    _dueDate = dueDate;

    final settingsBox = Hive.box('appSettings');
    await settingsBox.put('dueDate', dueDate.toIso8601String());

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

  void addKickSession(KickSession session) {
    _kickSessions.add(session);
    notifyListeners();
  }

  void removeKickSession(int index) {
    if (index >= 0 && index < _kickSessions.length) {
      _kickSessions.removeAt(index);
      notifyListeners();
    }
  }

  void addWeightEntry({required DateTime date, required double weight}) {
    _weightEntries.add(WeightEntry(date: date, weight: weight));
    notifyListeners();
  }

  void removeWeightEntry(WeightEntry entry) {
    _weightEntries.remove(entry);
    notifyListeners();
  }
}