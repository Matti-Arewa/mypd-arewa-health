//screens/category_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../widgets/question_card.dart';
import '../screens/question_detail_screen.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryId;

  const CategoryScreen({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Für die Filterung der Fragen
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

    // Responsive Design-Anpassungen
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final isSmallScreen = screenWidth < 360;

    if (category == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.tr('category')),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: Center(
          child: Text(context.tr('categoryNotFound')),
        ),
      );
    }

    // Fragen nach Filter anwenden
    final List<ContentQuestion> filteredQuestions = _filterQuestions(
        category.questions);

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
          // Header mit Bild - vereinfachte Version
          //_buildSimplifiedCategoryHeader(context, category, isSmallScreen),

          // Suchfeld und Filteroptionen
          _buildSearchAndFilter(context, isSmallScreen),

          // Liste der Fragen
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QuestionDetailScreen(
                              question: question,
                              categoryId: widget.categoryId,
                            ),
                      ),
                    );
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

  // Vereinfachter Header ohne Beschreibung und Anzeige der Fragenanzahl
  Widget _buildSimplifiedCategoryHeader(BuildContext context,
      ContentCategory category, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
      ),
      padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Kategorielogo/-bild
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              category.imageUrl,
              width: isSmallScreen ? 50 : 60,
              height: isSmallScreen ? 50 : 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: isSmallScreen ? 50 : 60,
                  height: isSmallScreen ? 50 : 60,
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.image,
                    color: AppTheme.primaryColor,
                  ),
                );
              },
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
              prefixIcon: const Icon(
                  Icons.search, color: AppTheme.primaryColor),
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

          // Filter-Optionen
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                _buildFilterChip(
                    context, 'all', context.tr('allQuestions'), isSmallScreen),
                _buildFilterChip(
                    context, 'favorites', context.tr('favoriteQuestions'),
                    isSmallScreen),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String value, String label,
      bool isSmallScreen) {
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
    final ContentProvider contentProvider = Provider.of<ContentProvider>(
        context, listen: false);

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
      filteredList =
          filteredList.where((q) => contentProvider.isFavorite(q.id)).toList();
    }

    return filteredList;
  }
}