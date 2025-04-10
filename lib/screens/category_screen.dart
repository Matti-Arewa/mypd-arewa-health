//screens/category_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../screens/question_detail_screen.dart';
import '../widgets/question_card.dart';
import '../services/localization_service.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryId;

  const CategoryScreen({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final category = contentProvider.getCategoryById(categoryId);

    // Bildschirmgröße für responsive Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    if (category == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.tr('category')),
        ),
        body: Center(
          child: Text(context.tr('categoryNotFound')),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildHeader(context, category, isSmallScreen),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final question = category.questions[index];
                return QuestionCard(
                  question: question.question,
                  isFavorite: contentProvider.isFavorite(question.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionDetailScreen(
                          categoryId: category.id,
                          question: question,
                        ),
                      ),
                    );
                  },
                  onFavoriteToggle: () {
                    contentProvider.toggleFavorite(question.id);
                  },
                );
              },
              childCount: category.questions.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ContentCategory category, bool isSmallScreen) {
    // Responsive Textstile basierend auf Bildschirmgröße
    final titleStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
      fontSize: isSmallScreen ? 18.0 : 22.0,
    );

    final descriptionStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: isSmallScreen ? 12.0 : 14.0,
    );

    final sectionTitleStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
      fontSize: isSmallScreen ? 16.0 : 18.0,
    );

    // Responsive Bildgröße und Abstände
    final imageSize = isSmallScreen ? 80.0 : 100.0;
    final padding = isSmallScreen ? 12.0 : 16.0;
    final spacing = isSmallScreen ? 8.0 : 16.0;

    return Container(
      padding: EdgeInsets.all(padding),
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  category.imageUrl,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: imageSize,
                      height: imageSize,
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      child: Icon(
                        Icons.image,
                        color: Theme.of(context).primaryColor,
                        size: imageSize * 0.4,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: titleStyle,
                    ),
                    SizedBox(height: spacing / 2),
                    Text(
                      category.description,
                      style: descriptionStyle,
                    ),
                    SizedBox(height: spacing / 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${category.questions.length} ${context.tr('questions')}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 10.0 : 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          const Divider(height: 1),
          SizedBox(height: spacing / 2),
          Text(
            context.tr('frequentlyAskedQuestions'),
            style: sectionTitleStyle,
          ),
          SizedBox(height: spacing / 2),
        ],
      ),
    );
  }
}