

// Kick counter model
class KickSession {
  final DateTime date;
  final int kickCount;
  final Duration sessionDuration;
  final String notes;

  KickSession({
    required this.date,
    required this.kickCount,
    required this.sessionDuration,
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'kickCount': kickCount,
      'durationInSeconds': sessionDuration.inSeconds,
      'notes': notes,
    };
  }

  factory KickSession.fromMap(Map<String, dynamic> map) {
    return KickSession(
      date: DateTime.parse(map['date']),
      kickCount: map['kickCount'],
      sessionDuration: Duration(seconds: map['durationInSeconds']),
      notes: map['notes'] ?? '',
    );
  }
}

// Weight tracker model
class WeightRecord {
  final DateTime date;
  final double weight;
  final String notes;

  WeightRecord({
    required this.date,
    required this.weight,
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'weight': weight,
      'notes': notes,
    };
  }

  factory WeightRecord.fromMap(Map<String, dynamic> map) {
    return WeightRecord(
      date: DateTime.parse(map['date']),
      weight: map['weight'],
      notes: map['notes'] ?? '',
    );
  }
}

// Search results model
class SearchResult {
  final String id;
  final String categoryId;
  final String categoryName;
  final String questionTitle;
  final String answerSnippet;
  final double relevanceScore;

  SearchResult({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.questionTitle,
    required this.answerSnippet,
    this.relevanceScore = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'questionTitle': questionTitle,
      'answerSnippet': answerSnippet,
      'relevanceScore': relevanceScore,
    };
  }

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    return SearchResult(
      id: map['id'],
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
      questionTitle: map['questionTitle'],
      answerSnippet: map['answerSnippet'],
      relevanceScore: map['relevanceScore'] ?? 0.0,
    );
  }
}

// Nutrition log model (for future enhancement)
class NutritionLog {
  final DateTime date;
  final List<MealEntry> meals;
  final int waterIntakeML;
  final bool tookPrenatalVitamin;
  final String notes;

  NutritionLog({
    required this.date,
    required this.meals,
    required this.waterIntakeML,
    this.tookPrenatalVitamin = false,
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'meals': meals.map((meal) => meal.toMap()).toList(),
      'waterIntakeML': waterIntakeML,
      'tookPrenatalVitamin': tookPrenatalVitamin,
      'notes': notes,
    };
  }

  factory NutritionLog.fromMap(Map<String, dynamic> map) {
    return NutritionLog(
      date: DateTime.parse(map['date']),
      meals: (map['meals'] as List)
          .map((meal) => MealEntry.fromMap(meal))
          .toList(),
      waterIntakeML: map['waterIntakeML'],
      tookPrenatalVitamin: map['tookPrenatalVitamin'] ?? false,
      notes: map['notes'] ?? '',
    );
  }
}

class MealEntry {
  final String mealType; // breakfast, lunch, dinner, snack
  final String description;
  final List<String> foodItems;

  MealEntry({
    required this.mealType,
    required this.description,
    required this.foodItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'mealType': mealType,
      'description': description,
      'foodItems': foodItems,
    };
  }

  factory MealEntry.fromMap(Map<String, dynamic> map) {
    return MealEntry(
      mealType: map['mealType'],
      description: map['description'],
      foodItems: List<String>.from(map['foodItems']),
    );
  }
}

// User settings model
class UserSettings {
  final String language;
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String weightUnit; // kg or lb
  final List<String> preferredCategories;

  UserSettings({
    this.language = 'en',
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
    this.weightUnit = 'kg',
    this.preferredCategories = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
      'weightUnit': weightUnit,
      'preferredCategories': preferredCategories,
    };
  }

  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      language: map['language'] ?? 'en',
      notificationsEnabled: map['notificationsEnabled'] ?? true,
      darkModeEnabled: map['darkModeEnabled'] ?? false,
      weightUnit: map['weightUnit'] ?? 'kg',
      preferredCategories: List<String>.from(map['preferredCategories'] ?? []),
    );
  }

  UserSettings copyWith({
    String? language,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? weightUnit,
    List<String>? preferredCategories,
  }) {
    return UserSettings(
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      weightUnit: weightUnit ?? this.weightUnit,
      preferredCategories: preferredCategories ?? this.preferredCategories,
    );
  }
}