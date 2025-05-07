import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../screens/question_detail_screen.dart';
import '../services/localization_service.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({super.key, this.initialQuery});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    // If an initial query was provided, start searching with it
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _searchController.text = widget.initialQuery!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _performSearch(_searchController.text,
            Provider.of<ContentProvider>(context, listen: false));
      });
    }
  }

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

    // Perform search across all sections, categories and questions
    final results = <SearchResult>[];

    // Search in all sections (chapters)
    for (final section in contentProvider.sections) {
      // Search in section (chapter) titles
      final isSectionMatch = section.title.toLowerCase().contains(query.toLowerCase());

      // Search in all categories within this section
      for (final category in section.categories) {
        // Search in category titles
        final isCategoryMatch = category.title.toLowerCase().contains(query.toLowerCase());

        // Search in questions and answers within this category
        for (final question in category.questions) {
          // If section or category matched, automatically include the question
          if (isSectionMatch) {
            results.add(
              SearchResult(
                question: question,
                categoryId: category.id,
                categoryTitle: category.title,
                sectionId: section.id,
                sectionTitle: section.title,
                matchType: MatchType.section,
              ),
            );
          } else if (isCategoryMatch) {
            results.add(
              SearchResult(
                question: question,
                categoryId: category.id,
                categoryTitle: category.title,
                sectionId: section.id,
                sectionTitle: section.title,
                matchType: MatchType.category,
              ),
            );
          }
          // Otherwise check if the question or answer matched
          else if (question.question.toLowerCase().contains(query.toLowerCase())) {
            results.add(
              SearchResult(
                question: question,
                categoryId: category.id,
                categoryTitle: category.title,
                sectionId: section.id,
                sectionTitle: section.title,
                matchType: MatchType.question,
              ),
            );
          } else if (question.answer.toLowerCase().contains(query.toLowerCase())) {
            results.add(
              SearchResult(
                question: question,
                categoryId: category.id,
                categoryTitle: category.title,
                sectionId: section.id,
                sectionTitle: section.title,
                matchType: MatchType.answer,
              ),
            );
          }
        }
      }
    }

    // Remove duplicates (same question might match multiple criteria)
    final uniqueResults = <SearchResult>[];
    final questionIds = <String>{};

    for (final result in results) {
      if (!questionIds.contains(result.question.id)) {
        questionIds.add(result.question.id);
        uniqueResults.add(result);
      }
    }

    setState(() {
      _searchResults = uniqueResults;
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
                prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchResults = [];
                    });
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppTheme.primaryColor),
                ),
              ),
              onChanged: (value) => _performSearch(value, contentProvider),
              onSubmitted: (value) => _performSearch(value, contentProvider),
              textInputAction: TextInputAction.search,
            ),
          ),

          // Results count
          if (_searchResults.isNotEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(padding, 0, padding, padding / 2),
              child: Row(
                children: [
                  Text(
                    '${_searchResults.length} ${context.tr('resultsFound')}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: isSmallScreen ? 13 : 14,
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: _isSearching
                ? const Center(child: CircularProgressIndicator())
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
      case MatchType.section:
        iconData = Icons.menu_book;
        iconColor = Colors.blue;
        break;
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
          final ContentProvider contentProvider = Provider.of<ContentProvider>(context, listen: false);
          final category = contentProvider.getCategoryById(result.categoryId);
          final section = category != null ? contentProvider.getSectionById(category.sectionId) : null;

          if (category != null && section != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => QuestionDetailScreen(
                  question: result.question,
                  category: category,
                  parentSection: section,
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb navigation for the result
              Row(
                children: [
                  Icon(
                    Icons.menu_book,
                    size: isSmallScreen ? 14 : 16,
                    color: AppTheme.primaryColor.withOpacity(0.7),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${result.sectionTitle} › ${result.categoryTitle}',
                      style: TextStyle(
                        color: AppTheme.primaryColor.withOpacity(0.7),
                        fontSize: isSmallScreen ? 12 : 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Question with icon
              Row(
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

                        // Preview of the answer (first few words)
                        if (result.question.answer.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            _getAnswerPreview(result.question.answer),
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: categoryFontSize,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getAnswerPreview(String answer) {
    // Clean up the answer text for preview
    final cleanText = answer
        .replaceAll(RegExp(r'\n+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    // Limit to a reasonable preview length
    const maxLength = 100;
    if (cleanText.length <= maxLength) {
      return cleanText;
    }

    return '${cleanText.substring(0, maxLength)}...';
  }
}

// Extended helper class for search functionality
enum MatchType { section, category, question, answer }

class SearchResult {
  final ContentQuestion question;
  final String categoryId;
  final String categoryTitle;
  final String sectionId;
  final String sectionTitle;
  final MatchType matchType;

  SearchResult({
    required this.question,
    required this.categoryId,
    required this.categoryTitle,
    required this.sectionId,
    required this.sectionTitle,
    required this.matchType,
  });
}