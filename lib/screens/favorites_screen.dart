import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../screens/question_detail_screen.dart';
import '../services/localization_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final favoriteQuestions = contentProvider.getFavoriteQuestions();

    // Responsive Design-Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('savedInformation'),
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: isSmallScreen ? 18.0 : 20.0,
          ),
        ),
      ),
      body: favoriteQuestions.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: isSmallScreen ? 60 : 80,
              color: Colors.grey[300],
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            Text(
              context.tr('noFavorites'),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isSmallScreen ? 6 : 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 24 : 32),
              child: Text(
                context.tr('noFavoritesDescription'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: isSmallScreen ? 13 : 14,
                ),
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        itemCount: favoriteQuestions.length,
        itemBuilder: (context, index) {
          final ContentQuestion question = favoriteQuestions[index];
          final categoryName = contentProvider
              .getCategoryById(question.categoryId)!
              .title;

          return Dismissible(
            key: Key(question.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              contentProvider.toggleFavorite(question.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.tr('removedFromFavorites')),
                  action: SnackBarAction(
                    label: context.tr('undo').toUpperCase(),
                    onPressed: () {
                      contentProvider.toggleFavorite(question.id);
                    },
                  ),
                ),
              );
            },
            child: Card(
              elevation: 2,
              margin: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => QuestionDetailScreen(
                        question: question,
                        categoryId: question.categoryId,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: isSmallScreen ? 16 : 20,
                            color: AppTheme.accentColor,
                          ),
                          SizedBox(width: isSmallScreen ? 6 : 8),
                          Text(
                            categoryName,
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 6 : 8),
                      Text(
                        question.question,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 3 : 4),
                      Text(
                        question.answer.length > 100
                            ? '${question.answer.substring(0, 100)}...'
                            : question.answer,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}