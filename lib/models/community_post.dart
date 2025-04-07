// models/community_post.dart
class CommunityPost {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String content;
  final DateTime postedAt;
  final int likesCount;
  final int commentsCount;
  final List<String> tags;
  final bool isExpert;

  CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.postedAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.tags = const [],
    this.isExpert = false,
  });
}

class Comment {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String content;
  final DateTime postedAt;
  final int likesCount;

  Comment({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.postedAt,
    this.likesCount = 0,
  });
}