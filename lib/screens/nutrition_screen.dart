import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';

class NutritionScreen extends StatelessWidget {
  static const routeName = '/nutrition';

  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Adjust sizes based on screen size
    final titleFontSize = isSmallScreen ? 18.0 : 22.0;
    final sectionTitleFontSize = isSmallScreen ? 16.0 : 18.0;
    final bodyTextFontSize = isSmallScreen ? 13.0 : 16.0;
    final categoryTitleFontSize = isSmallScreen ? 14.0 : 16.0;
    final categoryDescriptionFontSize = isSmallScreen ? 12.0 : 14.0;
    final challengeTitleFontSize = isSmallScreen ? 14.0 : 16.0;
    final noteFontSize = isSmallScreen ? 12.0 : 14.0;
    final padding = isSmallScreen ? 12.0 : 16.0;
    final sectionPadding = isSmallScreen ? 16.0 : 24.0;
    final imageHeight = isSmallScreen ? 160.0 : 200.0;

    return Scaffold(
      appBar: CustomAppBar(title: context.tr('nutritionDuringPregnancy'), backgroundColor: AppTheme.primaryColor,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/nutrition.jpg',
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: imageHeight,
                    width: double.infinity,
                    color: AppTheme.accentColor.withOpacity(0.2),
                    child: Icon(
                      Icons.restaurant,
                      size: isSmallScreen ? 48 : 64,
                      color: AppTheme.primaryColor,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: sectionPadding),

            // Introduction
            Text(
              context.tr('nutritionBasicsTitle'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
                fontSize: titleFontSize,
              ),
              overflow: TextOverflow.ellipsis,  // Overflow handling
              maxLines: 2,
            ),
            SizedBox(height: padding),
            Text(
              context.tr('nutritionBasicsDescription'),
              style: TextStyle(fontSize: bodyTextFontSize),
            ),
            SizedBox(height: sectionPadding),

            // Daily nutritional needs
            _buildSection(
              context,
              title: context.tr('dailyNutritionalNeeds'),
              icon: Icons.check_circle_outline,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNutrientItem(
                    context.tr('nutrientFolicAcid'),
                    context.tr('nutrientFolicAcidAmount'),
                    context.tr('nutrientFolicAcidDesc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildNutrientItem(
                    context.tr('nutrientIron'),
                    context.tr('nutrientIronAmount'),
                    context.tr('nutrientIronDesc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildNutrientItem(
                    context.tr('nutrientCalcium'),
                    context.tr('nutrientCalciumAmount'),
                    context.tr('nutrientCalciumDesc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildNutrientItem(
                    context.tr('nutrientProtein'),
                    context.tr('nutrientProteinAmount'),
                    context.tr('nutrientProteinDesc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildNutrientItem(
                    context.tr('nutrientOmega3'),
                    context.tr('nutrientOmega3Amount'),
                    context.tr('nutrientOmega3Desc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                ],
              ),
              isSmallScreen: isSmallScreen,
              sectionTitleFontSize: sectionTitleFontSize,
            ),
            SizedBox(height: sectionPadding),

            // Foods to enjoy
            _buildSection(
              context,
              title: context.tr('foodsToEnjoy'),
              icon: Icons.thumb_up_outlined,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FoodCategory(
                    title: context.tr('foodCategoryFruits'),
                    description: context.tr('foodCategoryFruitsDesc'),
                    examples: context.tr('foodCategoryFruitsExamples'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                  _FoodCategory(
                    title: context.tr('foodCategoryGrains'),
                    description: context.tr('foodCategoryGrainsDesc'),
                    examples: context.tr('foodCategoryGrainsExamples'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                  _FoodCategory(
                    title: context.tr('foodCategoryProteins'),
                    description: context.tr('foodCategoryProteinsDesc'),
                    examples: context.tr('foodCategoryProteinsExamples'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                  _FoodCategory(
                    title: context.tr('foodCategoryDairy'),
                    description: context.tr('foodCategoryDairyDesc'),
                    examples: context.tr('foodCategoryDairyExamples'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                  _FoodCategory(
                    title: context.tr('foodCategoryFats'),
                    description: context.tr('foodCategoryFatsDesc'),
                    examples: context.tr('foodCategoryFatsExamples'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                ],
              ),
              isSmallScreen: isSmallScreen,
              sectionTitleFontSize: sectionTitleFontSize,
            ),
            SizedBox(height: sectionPadding),

            // Foods to avoid
            _buildSection(
              context,
              title: context.tr('foodsToAvoid'),
              icon: Icons.not_interested,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AvoidFoodItem(
                    food: context.tr('avoidFoodRaw'),
                    reason: context.tr('avoidFoodRawReason'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                  _AvoidFoodItem(
                    food: context.tr('avoidFoodMercury'),
                    reason: context.tr('avoidFoodMercuryReason'),
                    examples: context.tr('avoidFoodMercuryExamples'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                  _AvoidFoodItem(
                    food: context.tr('avoidFoodUnpasteurized'),
                    reason: context.tr('avoidFoodUnpasteurizedReason'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                  _AvoidFoodItem(
                    food: context.tr('avoidFoodDeli'),
                    reason: context.tr('avoidFoodDeliReason'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                  _AvoidFoodItem(
                    food: context.tr('avoidFoodCaffeine'),
                    reason: context.tr('avoidFoodCaffeineReason'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                  _AvoidFoodItem(
                    food: context.tr('avoidFoodAlcohol'),
                    reason: context.tr('avoidFoodAlcoholReason'),
                    isSmallScreen: isSmallScreen,
                    titleFontSize: categoryTitleFontSize,
                    descriptionFontSize: categoryDescriptionFontSize,
                  ),
                ],
              ),
              isSmallScreen: isSmallScreen,
              sectionTitleFontSize: sectionTitleFontSize,
            ),
            SizedBox(height: sectionPadding),

            // Meal planning tips
            _buildSection(
              context,
              title: context.tr('mealPlanningTips'),
              icon: Icons.restaurant_menu,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTipItem(
                    context.tr('tipSmallMeals'),
                    context.tr('tipSmallMealsDesc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildTipItem(
                    context.tr('tipStayHydrated'),
                    context.tr('tipStayHydratedDesc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildTipItem(
                    context.tr('tipBalancedMeals'),
                    context.tr('tipBalancedMealsDesc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildTipItem(
                    context.tr('tipPrepareSnacks'),
                    context.tr('tipPrepareSnacksDesc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildTipItem(
                    context.tr('tipListenToBody'),
                    context.tr('tipListenToBodyDesc'),
                    isSmallScreen,
                    categoryTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                ],
              ),
              isSmallScreen: isSmallScreen,
              sectionTitleFontSize: sectionTitleFontSize,
            ),
            SizedBox(height: sectionPadding),

            // Managing nutrition challenges
            _buildSection(
              context,
              title: context.tr('managingChallenges'),
              icon: Icons.healing,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChallengeItem(
                    context.tr('challengeMorningSickness'),
                    [
                      context.tr('challengeMorningSicknessTip1'),
                      context.tr('challengeMorningSicknessTip2'),
                      context.tr('challengeMorningSicknessTip3'),
                      context.tr('challengeMorningSicknessTip4')
                    ],
                    isSmallScreen,
                    challengeTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildChallengeItem(
                    context.tr('challengeHeartburn'),
                    [
                      context.tr('challengeHeartburnTip1'),
                      context.tr('challengeHeartburnTip2'),
                      context.tr('challengeHeartburnTip3'),
                      context.tr('challengeHeartburnTip4')
                    ],
                    isSmallScreen,
                    challengeTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildChallengeItem(
                    context.tr('challengeConstipation'),
                    [
                      context.tr('challengeConstipationTip1'),
                      context.tr('challengeConstipationTip2'),
                      context.tr('challengeConstipationTip3'),
                      context.tr('challengeConstipationTip4')
                    ],
                    isSmallScreen,
                    challengeTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                  _buildChallengeItem(
                    context.tr('challengeAversions'),
                    [
                      context.tr('challengeAversionsTip1'),
                      context.tr('challengeAversionsTip2'),
                      context.tr('challengeAversionsTip3'),
                      context.tr('challengeAversionsTip4')
                    ],
                    isSmallScreen,
                    challengeTitleFontSize,
                    categoryDescriptionFontSize,
                  ),
                ],
              ),
              isSmallScreen: isSmallScreen,
              sectionTitleFontSize: sectionTitleFontSize,
            ),
            SizedBox(height: isSmallScreen ? 24 : 32),

            // Consultation note
            Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.accentColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppTheme.accentColor,
                    size: isSmallScreen ? 20 : 24,
                  ),
                  SizedBox(width: isSmallScreen ? 12 : 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('note'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 2 : 4),
                        Text(
                          context.tr('consultationNote'),
                          style: TextStyle(fontSize: noteFontSize),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: padding * 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Widget content,
        required bool isSmallScreen,
        required double sectionTitleFontSize,
      }) {
    final padding = isSmallScreen ? 12.0 : 16.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: isSmallScreen ? 20 : 24,
                ),
                SizedBox(width: isSmallScreen ? 8 : 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                    fontSize: sectionTitleFontSize,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientItem(
      String nutrient,
      String recommendation,
      String description,
      bool isSmallScreen,
      double titleFontSize,
      double descriptionFontSize,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.fiber_manual_record,
                size: isSmallScreen ? 8 : 10,
                color: AppTheme.primaryColor,
              ),
              SizedBox(width: isSmallScreen ? 6 : 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nutrient,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                      ),
                      overflow: TextOverflow.ellipsis,  // Overflow handling
                      maxLines: 2,
                    ),
                    Text(
                      recommendation,
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: descriptionFontSize,
                      ),
                      overflow: TextOverflow.ellipsis,  // Overflow handling
                      maxLines: 2,
                    ),
                    SizedBox(height: isSmallScreen ? 2 : 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: descriptionFontSize),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(
      String title,
      String description,
      bool isSmallScreen,
      double titleFontSize,
      double descriptionFontSize,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            size: isSmallScreen ? 16 : 18,
            color: AppTheme.primaryColor,
          ),
          SizedBox(width: isSmallScreen ? 8 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: titleFontSize,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 2 : 4),
                Text(
                  description,
                  style: TextStyle(fontSize: descriptionFontSize),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeItem(
      String challenge,
      List<String> tips,
      bool isSmallScreen,
      double titleFontSize,
      double descriptionFontSize,
      ) {
    final bulletPointSpacing = isSmallScreen ? 2.0 : 4.0;

    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            challenge,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: titleFontSize,
            ),
          ),
          SizedBox(height: isSmallScreen ? 6 : 8),
          ...tips.map((tip) => Padding(
            padding: EdgeInsets.only(bottom: bulletPointSpacing),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                    fontSize: descriptionFontSize,
                  ),
                ),
                Expanded(
                  child: Text(
                    tip,
                    style: TextStyle(fontSize: descriptionFontSize),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _FoodCategory extends StatelessWidget {
  final String title;
  final String description;
  final String examples;
  final bool isSmallScreen;
  final double titleFontSize;
  final double descriptionFontSize;

  const _FoodCategory({
    required this.title,
    required this.description,
    required this.examples,
    required this.isSmallScreen,
    required this.titleFontSize,
    required this.descriptionFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: titleFontSize,
            ),
          ),
          SizedBox(height: isSmallScreen ? 2 : 4),
          Text(
            description,
            style: TextStyle(fontSize: descriptionFontSize),
          ),
          SizedBox(height: isSmallScreen ? 1 : 2),
          Text(
            context.tr('examples') + ': ' + examples,
            style: TextStyle(
              fontSize: descriptionFontSize,
              fontStyle: FontStyle.italic,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvoidFoodItem extends StatelessWidget {
  final String food;
  final String reason;
  final String? examples;
  final bool isSmallScreen;
  final double titleFontSize;
  final double descriptionFontSize;

  const _AvoidFoodItem({
    required this.food,
    required this.reason,
    this.examples,
    required this.isSmallScreen,
    required this.titleFontSize,
    required this.descriptionFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            food,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: titleFontSize,
            ),
          ),
          SizedBox(height: isSmallScreen ? 2 : 4),
          Text(
            reason,
            style: TextStyle(fontSize: descriptionFontSize),
          ),
          if (examples != null) ...[
            SizedBox(height: isSmallScreen ? 1 : 2),
            Text(
              context.tr('examples') + ': ' + examples!,
              style: TextStyle(
                fontSize: descriptionFontSize,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
          ],
        ],
      ),
    );
  }
}