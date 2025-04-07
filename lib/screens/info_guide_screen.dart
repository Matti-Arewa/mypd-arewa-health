// screens/info_guide_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/content_provider.dart';
import '../providers/user_provider.dart';
import '../screens/category_screen.dart';
import '../widgets/category_card.dart';
import '../utils/app_theme.dart';

class InfoGuideScreen extends StatelessWidget {
  const InfoGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    if (contentProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final categories = contentProvider.categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schwangerschaftsratgeber',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with pregnancy progress
            _buildHeader(context, userProvider),

            // Categories section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Informationskategorien',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
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
                          builder: (context) => CategoryScreen(
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

  Widget _buildHeader(BuildContext context, UserProvider userProvider) {
    // If no due date is set, show a smaller header
    if (userProvider.dueDate == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        color: AppTheme.primaryColor.withOpacity(0.1),
        child: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: AppTheme.primaryColor,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Willkommen zum umfassenden Schwangerschaftsratgeber. Hier finden Sie Informationen zu allen wichtigen Themen rund um die Schwangerschaft.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // If due date is set, show pregnancy progress
    return Container(
      padding: const EdgeInsets.all(16),
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
            'Schwangerschaftswoche ${userProvider.weeksPregnant}',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Noch ${userProvider.daysLeft} Tage bis zum errechneten Termin',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),

          // Recommendations based on current week
          Container(
            padding: const EdgeInsets.all(16),
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
                  'Empfehlungen für diese Woche',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                _buildWeeklyRecommendation(context, userProvider.weeksPregnant),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    // Find which category is relevant for current week and navigate there
                    _navigateToRelevantCategory(context, userProvider.weeksPregnant);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Mehr erfahren'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyRecommendation(BuildContext context, int week) {
    String recommendation;

    // Provide different recommendations based on pregnancy week
    if (week < 13) {
      recommendation = 'Im ersten Trimester ist Folsäure besonders wichtig. Richte deinen Fokus auf nährstoffreiche Lebensmittel und ausreichend Ruhe.';
    } else if (week < 28) {
      recommendation = 'Im zweiten Trimester kannst du moderate Bewegung genießen. Es ist auch Zeit für die wichtigen Vorsorgeuntersuchungen.';
    } else {
      recommendation = 'Im dritten Trimester bereite dich auf die Geburt vor und schone dich. Achte besonders auf deine Körpersignale.';
    }

    return Text(
      recommendation,
      style: Theme.of(context).textTheme.bodyMedium,
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
        builder: (context) => CategoryScreen(
          categoryId: categoryId,
        ),
      ),
    );
  }
}