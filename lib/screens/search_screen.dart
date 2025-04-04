//screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../screens/question_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query, ContentProvider contentProvider) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // Perform search across all categories and questions
    final results = <SearchResult>[];

    for (final category in contentProvider.categories) {
      // Search in category titles
      if (category.title.toLowerCase().contains(query.toLowerCase())) {
        for (final question in category.questions) {
          results.add(
            SearchResult(
              question: question,
              categoryId: category.id,
              categoryTitle: category.title,
              matchType: MatchType.category,
            ),
          );
        }
      }

      // Search in questions and answers
      for (final question in category.questions) {
        if (question.question.toLowerCase().contains(query.toLowerCase())) {
          results.add(
            SearchResult(
              question: question,
              categoryId: category.id,
              categoryTitle: category.title,
              matchType: MatchType.question,
            ),
          );
        } else if (question.answer.toLowerCase().contains(query.toLowerCase())) {
          results.add(
            SearchResult(
              question: question,
              categoryId: category.id,
              categoryTitle: category.title,
              matchType: MatchType.answer,
            ),
          );
        }
      }
    }

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for topics, questions...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchResults = [];
                    });
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppTheme.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
              ),
              onChanged: (value) => _performSearch(value, contentProvider),
            ),
          ),
          Expanded(
            child: _isSearching
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty && _searchController.text.isNotEmpty
                ? const Center(
              child: Text('No results found. Try different keywords.'),
            )
                : _searchResults.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Search for pregnancy information',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return _buildSearchResultItem(context, result);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(BuildContext context, SearchResult result) {
    IconData iconData;
    Color iconColor;

    // Choose icon based on match type
    switch (result.matchType) {
      case MatchType.category:
        iconData = Icons.category;
        iconColor = Colors.green;
        break;
      case MatchType.question:
        iconData = Icons.question_answer;
        iconColor = AppTheme.primaryColor;
        break;
      case MatchType.answer:
        iconData = Icons.article;
        iconColor = AppTheme.accentColor;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => QuestionDetailScreen(
                question: result.question,
                categoryId: result.categoryId,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                color: iconColor,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.question.question,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'In: ${result.categoryTitle}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper classes for search functionality
enum MatchType { category, question, answer }

class SearchResult {
  final ContentQuestion question;
  final String categoryId;
  final String categoryTitle;
  final MatchType matchType;

  SearchResult({
    required this.question,
    required this.categoryId,
    required this.categoryTitle,
    required this.matchType,
  });
}