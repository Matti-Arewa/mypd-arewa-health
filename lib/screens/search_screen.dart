import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../screens/question_detail_screen.dart';
import '../services/localization_service.dart';

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

    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Adjust sizes based on screen size
    final titleFontSize = isSmallScreen ? 18.0 : 20.0;
    final cardFontSize = isSmallScreen ? 14.0 : 16.0;
    final padding = isSmallScreen ? 12.0 : 16.0;
    final cardPadding = isSmallScreen ? 12.0 : 16.0;
    final iconSize = isSmallScreen ? 20.0 : 24.0;
    final placeholderIconSize = isSmallScreen ? 60.0 : 80.0;
    final emptyMessageSize = isSmallScreen ? 14.0 : 16.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('search'),
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: titleFontSize,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(padding),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: context.tr('searchHint'),
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
                ? Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty && _searchController.text.isNotEmpty
                ? Center(
              child: Text(
                context.tr('noResultsFound'),
                style: TextStyle(fontSize: emptyMessageSize),
              ),
            )
                : _searchResults.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: placeholderIconSize,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: padding),
                  Text(
                    context.tr('searchForInformation'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: emptyMessageSize,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return _buildSearchResultItem(
                  context,
                  result,
                  isSmallScreen,
                  cardFontSize,
                  cardPadding,
                  iconSize,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(
      BuildContext context,
      SearchResult result,
      bool isSmallScreen,
      double fontSize,
      double padding,
      double iconSize,
      ) {
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

    final categoryFontSize = fontSize - 2;

    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: isSmallScreen ? 6 : 8
      ),
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
          padding: EdgeInsets.all(padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                color: iconColor,
                size: iconSize,
              ),
              SizedBox(width: isSmallScreen ? 12 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.question.question,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 2 : 4),
                    Text(
                      context.tr('inCategory', {'category': result.categoryTitle}),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: categoryFontSize,
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