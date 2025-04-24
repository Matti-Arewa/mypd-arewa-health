// models/nochOUTDATED_community_post.dart
import 'package:flutter/material.dart';
import '../services/localization_service.dart';

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

  // Lokalisierte Methode für Zeitangaben
  String getFormattedPostTime(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(postedAt);

    if (difference.inMinutes < 1) {
      return context.tr('justNow');
    } else if (difference.inHours < 1) {
      final minutes = difference.inMinutes;
      return context.tr('minutesAgo', {'count': minutes.toString()});
    } else if (difference.inDays < 1) {
      final hours = difference.inHours;
      return context.tr('hoursAgo', {'count': hours.toString()});
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return context.tr('daysAgo', {'count': days.toString()});
    } else {
      return '${postedAt.day}.${postedAt.month}.${postedAt.year}';
    }
  }
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

  // Lokalisierte Methode für Zeitangaben
  String getFormattedPostTime(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(postedAt);

    if (difference.inMinutes < 1) {
      return context.tr('justNow');
    } else if (difference.inHours < 1) {
      final minutes = difference.inMinutes;
      return context.tr('minutesAgo', {'count': minutes.toString()});
    } else if (difference.inDays < 1) {
      final hours = difference.inHours;
      return context.tr('hoursAgo', {'count': hours.toString()});
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return context.tr('daysAgo', {'count': days.toString()});
    } else {
      return '${postedAt.day}.${postedAt.month}.${postedAt.year}';
    }
  }
}