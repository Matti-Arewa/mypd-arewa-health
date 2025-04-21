// models/content_model.dart
class ContentSection {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<ContentCategory> categories;

  ContentSection({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.categories,
  });

  factory ContentSection.fromJson(Map<String, dynamic> json) {
    List<ContentCategory> categoriesList = [];
    if (json['categories'] != null) {
      categoriesList = List<ContentCategory>.from(
        json['categories'].map((c) => ContentCategory.fromJson(c)),
      );
    }

    return ContentSection(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? 'assets/images/placeholder.png',
      categories: categoriesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'categories': categories.map((c) => c.toJson()).toList(),
    };
  }
}

class ContentCategory {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String sectionId;
  final List<ContentQuestion> questions;

  ContentCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.sectionId,
    required this.questions,
  });

  factory ContentCategory.fromJson(Map<String, dynamic> json) {
    List<ContentQuestion> questionsList = [];
    if (json['questions'] != null) {
      questionsList = List<ContentQuestion>.from(
        json['questions'].map((q) => ContentQuestion.fromJson(q)),
      );
    }

    return ContentCategory(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? 'assets/images/placeholder.png',
      sectionId: json['sectionId'] ?? '',
      questions: questionsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'sectionId': sectionId,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}

class ContentQuestion {
  final String id;
  final String question;
  final String answer;
  final List<String> mediaUrls;
  final String categoryId;

  ContentQuestion({
    required this.id,
    required this.question,
    required this.answer,
    this.mediaUrls = const [],
    required this.categoryId,
  });

  factory ContentQuestion.fromJson(Map<String, dynamic> json) {
    List<String> media = [];
    if (json['mediaUrls'] != null) {
      media = List<String>.from(json['mediaUrls']);
    }

    return ContentQuestion(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      mediaUrls: media,
      categoryId: json['categoryId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'mediaUrls': mediaUrls,
      'categoryId': categoryId,
    };
  }
}

class ContentData {
  final List<ContentSection> sections;

  ContentData({required this.sections});

  factory ContentData.fromJson(Map<String, dynamic> json) {
    List<ContentSection> sectionsList = [];
    if (json['sections'] != null) {
      sectionsList = List<ContentSection>.from(
        json['sections'].map((s) => ContentSection.fromJson(s)),
      );
    }

    return ContentData(sections: sectionsList);
  }

  Map<String, dynamic> toJson() {
    return {
      'sections': sections.map((s) => s.toJson()).toList(),
    };
  }
}