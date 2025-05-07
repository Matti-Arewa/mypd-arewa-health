import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../screens/question_detail_screen.dart';
import '../widgets/question_card.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import 'package:flutter/foundation.dart';

class SubcategoryScreen extends StatefulWidget {
  final String categoryId;

  const SubcategoryScreen({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  String _filter = 'all';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final category = contentProvider.getCategoryById(widget.categoryId);

    // Get the parent section for breadcrumb navigation
    ContentSection? parentSection;
    if (category != null) {
      parentSection = contentProvider.getSectionById(category.sectionId);
    }

    // Responsive Design-Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    if (category == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.tr('subcategory')),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: Center(
          child: Text(context.tr('subcategoryNotFound')),
        ),
      );
    }

    // Fragen nach Filter anwenden
    final List<ContentQuestion> filteredQuestions = _filterQuestions(category.questions);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.title,
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: isSmallScreen ? 18.0 : 20.0,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        children: [
          // Breadcrumb navigation header
          _buildBreadcrumbHeader(context, category, parentSection, isSmallScreen),

          // Search and filter options
          //_buildSearchAndFilter(context, isSmallScreen),

          // Questions header
          Padding(
            padding: EdgeInsets.fromLTRB(16, isSmallScreen ? 4 : 8, 16, isSmallScreen ? 2 : 4),
            child: Row(
              children: [
                const Icon(Icons.question_answer, color: AppTheme.primaryColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  context.tr('questions'),
                  style: TextStyle(
                    fontSize: isSmallScreen
                        ? AppTheme.fontSizeBodyMedium
                        : AppTheme.fontSizeBodyLarge,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                // Show question count badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    filteredQuestions.length.toString(),
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List of questions
          Expanded(
            child: filteredQuestions.isEmpty
                ? Center(
              child: Text(
                _searchController.text.isNotEmpty
                    ? context.tr('noSearchResults')
                    : context.tr('noQuestionsInCategory'),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: isSmallScreen ? 14.0 : 16.0,
                ),
              ),
            )
                : ListView.builder(
              key: const PageStorageKey('question-list'),
              padding: EdgeInsets.only(bottom: 16),
              itemCount: filteredQuestions.length,
              itemBuilder: (context, index) {
                final question = filteredQuestions[index];

                return QuestionCard(
                  question: question.question,
                  isFavorite: contentProvider.isFavorite(question.id),
                  onTap: () {
                    final ContentProvider contentProvider = Provider.of<ContentProvider>(context, listen: false);
                    final category = contentProvider.getCategoryById(widget.categoryId);
                    final section = category != null ? contentProvider.getSectionById(category.sectionId) : null;

                    if (category != null && section != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionDetailScreen(
                            question: question,
                            category: category,
                            parentSection: section,
                          ),
                        ),
                      );
                    }
                  },
                  onFavoriteToggle: () {
                    contentProvider.toggleFavorite(question.id);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbHeader(
      BuildContext context,
      ContentCategory category,
      ContentSection? parentSection,
      bool isSmallScreen,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: isSmallScreen ? 8 : 12,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Home icon
          Icon(
            Icons.home,
            size: isSmallScreen ? 16 : 18,
            color: Colors.grey[600],
          ),

          // Parent section (chapter)
          if (parentSection != null) ...[
            Icon(
              Icons.chevron_right,
              size: isSmallScreen ? 16 : 18,
              color: Colors.grey[600],
            ),
            GestureDetector(
              onTap: () {
                // Navigate back to chapter screen
                Navigator.pop(context);
              },
              child: Text(
                parentSection.title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ],

          // Current category
          Icon(
            Icons.chevron_right,
            size: isSmallScreen ? 16 : 18,
            color: Colors.grey[600],
          ),
          Flexible(
            child: Text(
              category.title,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12.0 : 16.0,
        vertical: 8.0,
      ),
      child: Column(
        children: [
          // Suchfeld
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: context.tr('searchQuestions'),
              prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
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
              contentPadding: EdgeInsets.symmetric(
                vertical: isSmallScreen ? 8.0 : 12.0,
                horizontal: 16.0,
              ),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() {
                // Suche wird bei jeder Änderung aktualisiert
              });
            },
            style: TextStyle(
              fontSize: isSmallScreen ? 14.0 : 16.0,
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String value, String label, bool isSmallScreen) {
    final isSelected = _filter == value;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _filter = value;
            });
          }
        },
        backgroundColor: Colors.grey[200],
        selectedColor: AppTheme.primaryColor.withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.primaryColor : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: isSmallScreen ? 12.0 : 14.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12.0 : 16.0,
          vertical: 4.0,
        ),
      ),
    );
  }

  List<ContentQuestion> _filterQuestions(List<ContentQuestion> questions) {
    final ContentProvider contentProvider = Provider.of<ContentProvider>(context, listen: false);

    // Zuerst den Textfilter anwenden
    List<ContentQuestion> filteredList = [];
    if (_searchController.text.isNotEmpty) {
      final searchText = _searchController.text.toLowerCase();
      filteredList = questions.where((q) =>
      q.question.toLowerCase().contains(searchText) ||
          q.answer.toLowerCase().contains(searchText)
      ).toList();
    } else {
      filteredList = List.from(questions);
    }

    // Dann den Kategoriefilter anwenden
    if (_filter == 'favorites') {
      filteredList = filteredList.where((q) => contentProvider.isFavorite(q.id)).toList();
    }

    return filteredList;
  }
}