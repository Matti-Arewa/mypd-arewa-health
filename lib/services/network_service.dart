import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/content_model.dart';

class SearchResult {
  final String id;
  final String title;
  final String snippet; // Beispielhaftes Feld

  SearchResult({
    required this.id,
    required this.title,
    required this.snippet,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      snippet: json['snippet'] ?? '',
    );
  }
}

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  // This is a placeholder API URL - replace with your actual API endpoint
  final String _baseUrl = 'https://your-pregnancy-app-api.com/api';

  // Placeholder for API key or auth token that would be used in a real app
  String? _authToken;

  // Set authentication token (for future use with user accounts)
  void setAuthToken(String token) {
    _authToken = token;
  }

  // Headers for API requests
  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  // Fetch all categories and their content
  Future<List<ContentCategory>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/categories'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ContentCategory.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      // For now, return empty list. In production, handle errors appropriately
      print('Error fetching categories: $e');
      return [];
    }
  }

  // Fetch a specific category by ID
  Future<ContentCategory?> fetchCategory(String categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/categories/$categoryId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ContentCategory.fromJson(data);
      } else {
        throw Exception('Failed to load category: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching category: $e');
      return null;
    }
  }



  // Search content across all categories
  Future<List<SearchResult>> searchContent(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search?q=$query'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => SearchResult.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search content: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching content: $e');
      return [];
    }
  }

  // POST feedback on content (for future versions)
  Future<bool> submitFeedback(String contentId, String feedback, int rating) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/feedback'),
        headers: _headers,
        body: json.encode({
          'contentId': contentId,
          'feedback': feedback,
          'rating': rating,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error submitting feedback: $e');
      return false;
    }
  }

  // Get latest content updates (for syncing)
  Future<DateTime> getLatestUpdateTime() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/updates/latest'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return DateTime.parse(data['lastUpdated']);
      } else {
        throw Exception('Failed to get latest update time: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching update time: $e');
      // Return current time if failed
      return DateTime.now();
    }
  }

  // This is a mock method to check if there are updates available
  Future<bool> checkForUpdates(DateTime lastLocalUpdate) async {
    try {
      final latestUpdate = await getLatestUpdateTime();
      return latestUpdate.isAfter(lastLocalUpdate);
    } catch (e) {
      print('Error checking for updates: $e');
      return false;
    }
  }
}