// screens/info_guide_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/content_provider.dart';
import '../providers/user_provider.dart';
import '../screens/category_screen.dart';
import '../widgets/category_card.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';

class InfoGuideScreen extends StatelessWidget {
  const InfoGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    // Bildschirmgröße für responsive Anpassungen
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    if (contentProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final categories = contentProvider.categories;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('app_name'),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with pregnancy progress
            _buildHeader(context, userProvider, isSmallScreen),

            // Categories section
            Padding(
              padding: EdgeInsets.fromLTRB(
                  16,
                  isSmallScreen ? 12 : 16,
                  16,
                  isSmallScreen ? 6 : 8
              ),
              child: Text(
                context.tr('informationCategories'),
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(
                  fontSize: isSmallScreen ? 18.0 : 22.0,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(
                    title: category.title,
                    description: category.description,
                    imageUrl: category.imageUrl,
                    questionCount: category.questions.length,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(
                                categoryId: category.id,
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserProvider userProvider,
      bool isSmallScreen) {
    // If no due date is set, show a smaller header
    if (userProvider.dueDate == null) {
      return Container(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        color: AppTheme.primaryColor.withOpacity(0.1),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppTheme.primaryColor,
              size: isSmallScreen ? 24 : 32,
            ),
            SizedBox(width: isSmallScreen ? 12 : 16),
            Expanded(
              child: Text(
                context.tr('pregnancyGuideWelcome'),
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                  height: 1.5,
                  fontSize: isSmallScreen ? 13.0 : 15.0,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // If due date is set, show pregnancy progress
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.9),
            AppTheme.primaryColor.withOpacity(0.7),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr(
                'pregnancyWeek', {'week': '${userProvider.weeksPregnant}'}),
            style: Theme
                .of(context)
                .textTheme
                .displayMedium
                ?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 18.0 : 22.0,
            ),
          ),
          SizedBox(height: isSmallScreen ? 6 : 8),
          Text(
            context.tr(
                'daysUntilDueDate', {'days': '${userProvider.daysLeft}'}),
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontSize: isSmallScreen ? 14.0 : 16.0,
            ),
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),

          // Recommendations based on current week
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('recommendationsForWeek'),
                  style: Theme
                      .of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(
                    fontSize: isSmallScreen ? 16.0 : 18.0,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 6 : 8),
                _buildWeeklyRecommendation(
                    context, userProvider.weeksPregnant, isSmallScreen),
                SizedBox(height: isSmallScreen ? 10 : 12),
                ElevatedButton.icon(
                  onPressed: () {
                    // Find which category is relevant for current week and navigate there
                    _navigateToRelevantCategory(
                        context, userProvider.weeksPregnant);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 16,
                      vertical: isSmallScreen ? 8 : 10,
                    ),
                  ),
                  icon: Icon(
                      Icons.arrow_forward, size: isSmallScreen ? 16 : 18),
                  label: Text(
                    context.tr('learnMore'),
                    style: TextStyle(fontSize: isSmallScreen ? 12.0 : 14.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyRecommendation(BuildContext context, int week,
      bool isSmallScreen) {
    String recommendationKey;

    // Provide different recommendations based on pregnancy week
    if (week < 13) {
      recommendationKey = 'trimester1Tip';
    } else if (week < 28) {
      recommendationKey = 'trimester2Tip';
    } else {
      recommendationKey = 'trimester3Tip';
    }

    return Text(
      context.tr(recommendationKey),
      style: Theme
          .of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(
        fontSize: isSmallScreen ? 13.0 : 14.0,
      ),
    );
  }

  void _navigateToRelevantCategory(BuildContext context, int week) {
    // Determine which category is relevant based on current pregnancy week
    String categoryId;
    if (week < 13) {
      categoryId = 'pregnancy_stages'; // First trimester
    } else if (week < 28) {
      categoryId = 'exercise'; // Second trimester - exercise is important
    } else if (week < 37) {
      categoryId = 'birth_preparation'; // Getting close to birth
    } else {
      categoryId = 'late_birth'; // Close to or past due date
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CategoryScreen(
              categoryId: categoryId,
            ),
      ),
    );
  }
}