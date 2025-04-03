import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/app_theme.dart';

class NutritionScreen extends StatelessWidget {
  static const routeName = '/nutrition';

  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Nutrition During Pregnancy'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/nutrition.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: AppTheme.accentColor.withOpacity(0.2),
                    child: const Icon(
                      Icons.restaurant,
                      size: 64,
                      color: AppTheme.primaryColor,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Introduction
            Text(
              'Eating for Two: Nutrition Basics',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Proper nutrition during pregnancy is crucial for both your health and your baby\'s development. Understanding what to eat, how much, and which nutrients are particularly important can help ensure a healthy pregnancy.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Daily nutritional needs
            _buildSection(
              context,
              title: 'Daily Nutritional Needs',
              icon: Icons.check_circle_outline,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNutrientItem(
                    'Folate/Folic Acid',
                    '600-800 mcg daily',
                    'Helps prevent neural tube defects. Found in leafy greens, fortified cereals, and supplements.',
                  ),
                  _buildNutrientItem(
                    'Iron',
                    '27 mg daily',
                    'Prevents anemia and supports baby\'s blood supply. Found in lean red meat, beans, and fortified cereals.',
                  ),
                  _buildNutrientItem(
                    'Calcium',
                    '1,000 mg daily',
                    'Builds baby\'s bones and teeth. Found in dairy products, fortified plant milks, and leafy greens.',
                  ),
                  _buildNutrientItem(
                    'Protein',
                    '75-100 g daily',
                    'Supports baby\'s growth. Found in meat, poultry, fish, eggs, beans, and dairy.',
                  ),
                  _buildNutrientItem(
                    'Omega-3 Fatty Acids',
                    '200-300 mg DHA daily',
                    'Supports brain and eye development. Found in fatty fish, walnuts, and flaxseeds.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Foods to enjoy
            _buildSection(
              context,
              title: 'Foods to Enjoy',
              icon: Icons.thumb_up_outlined,
              content: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FoodCategory(
                    title: 'Fruits & Vegetables',
                    description: 'Aim for 5+ servings daily, with a variety of colors.',
                    examples: 'Spinach, kale, carrots, sweet potatoes, bananas, berries',
                  ),
                  _FoodCategory(
                    title: 'Whole Grains',
                    description: 'Provide fiber and essential nutrients.',
                    examples: 'Brown rice, whole wheat bread, oats, quinoa',
                  ),
                  _FoodCategory(
                    title: 'Lean Proteins',
                    description: 'Important for baby\'s growth.',
                    examples: 'Chicken, fish, beans, lentils, tofu, eggs',
                  ),
                  _FoodCategory(
                    title: 'Dairy & Calcium-Rich Foods',
                    description: 'Essential for bone development.',
                    examples: 'Milk, yogurt, cheese, fortified plant milks',
                  ),
                  _FoodCategory(
                    title: 'Healthy Fats',
                    description: 'Support brain development.',
                    examples: 'Avocados, nuts, seeds, olive oil',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Foods to avoid
            _buildSection(
              context,
              title: 'Foods to Avoid',
              icon: Icons.not_interested,
              content: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AvoidFoodItem(
                    food: 'Raw or undercooked meat, poultry, fish, and eggs',
                    reason: 'Risk of harmful bacteria and parasites (salmonella, E. coli, listeria)',
                  ),
                  _AvoidFoodItem(
                    food: 'High-mercury fish',
                    reason: 'Mercury can harm baby\'s developing nervous system',
                    examples: 'Shark, swordfish, king mackerel, tilefish',
                  ),
                  _AvoidFoodItem(
                    food: 'Unpasteurized dairy and juices',
                    reason: 'Risk of bacterial contamination',
                  ),
                  _AvoidFoodItem(
                    food: 'Deli meats and hot dogs',
                    reason: 'Risk of listeria unless thoroughly heated',
                  ),
                  _AvoidFoodItem(
                    food: 'Excessive caffeine',
                    reason: 'Limit to 200mg daily (about one 12oz cup of coffee)',
                  ),
                  _AvoidFoodItem(
                    food: 'Alcohol',
                    reason: 'No safe level during pregnancy, can cause birth defects',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Meal planning tips
            _buildSection(
              context,
              title: 'Meal Planning Tips',
              icon: Icons.restaurant_menu,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTipItem(
                    'Eat smaller, frequent meals',
                    'This can help manage nausea and maintain energy levels.',
                  ),
                  _buildTipItem(
                    'Stay hydrated',
                    'Aim for 8-10 glasses of water daily to support blood volume expansion and amniotic fluid.',
                  ),
                  _buildTipItem(
                    'Plan balanced meals',
                    'Include protein, complex carbohydrates, healthy fats, and fruits/vegetables at each meal.',
                  ),
                  _buildTipItem(
                    'Prepare snacks in advance',
                    'Keep nuts, cut vegetables, yogurt, or fruit on hand for healthy snacking.',
                  ),
                  _buildTipItem(
                    'Listen to your body',
                    'Honor your hunger and fullness cues rather than restricting food.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Managing nutrition challenges
            _buildSection(
              context,
              title: 'Managing Nutrition Challenges',
              icon: Icons.healing,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChallengeItem(
                    'Morning Sickness',
                    [
                      'Eat small, frequent meals',
                      'Keep crackers by your bed',
                      'Try ginger tea or candies',
                      'Avoid triggering smells or foods'
                    ],
                  ),
                  _buildChallengeItem(
                    'Heartburn',
                    [
                      'Eat smaller meals',
                      'Avoid spicy, fatty, or acidic foods',
                      'Don\'t lie down right after eating',
                      'Ask your doctor about safe antacids'
                    ],
                  ),
                  _buildChallengeItem(
                    'Constipation',
                    [
                      'Increase fiber intake gradually',
                      'Stay well hydrated',
                      'Regular physical activity',
                      'Consider prune juice or fiber supplements'
                    ],
                  ),
                  _buildChallengeItem(
                    'Food Aversions',
                    [
                      'Find alternative sources of key nutrients',
                      'Try different preparations of nutritious foods',
                      'Cold foods may be more tolerable when nauseous',
                      'Focus on what you can eat, not what you can\'t'
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Consultation note
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.accentColor.withOpacity(0.3),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppTheme.accentColor,
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'This information is general guidance. Always consult with your healthcare provider about your specific nutritional needs during pregnancy.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
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
      }) {
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
            padding: const EdgeInsets.all(16),
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
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientItem(String nutrient, String recommendation, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.fiber_manual_record,
                size: 10,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nutrient,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      recommendation,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14),
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

  Widget _buildTipItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check,
            size: 18,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeItem(String challenge, List<String> tips) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            challenge,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          ...tips.map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '• ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                Expanded(
                  child: Text(tip),
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

  const _FoodCategory({
    required this.title,
    required this.description,
    required this.examples,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(
            'Examples: $examples',
            style: TextStyle(
              fontSize: 14,
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

  const _AvoidFoodItem({
    required this.food,
    required this.reason,
    this.examples,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            food,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            reason,
            style: const TextStyle(fontSize: 14),
          ),
          if (examples != null) ...[
            const SizedBox(height: 2),
            Text(
              'Examples: $examples',
              style: TextStyle(
                fontSize: 14,
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