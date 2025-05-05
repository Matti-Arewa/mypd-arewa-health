import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/localization_service.dart';
import '../widgets/video_player_widget.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '/help';

  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive Design-Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Get video asset path based on language
    // Default Video
    const String videoAssetPath = 'assets/videos/intro.mp4';

    return Scaffold(
      appBar: CustomAppBar(
        title: context.tr('helpTitle'),
        backgroundColor: AppTheme.primaryColor,
        showBackButton: true,
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Help intro text
              Text(
                context.tr('helpIntroduction'),
                style: TextStyle(
                  fontSize: isSmallScreen ? 16.0 : 18.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              SizedBox(height: isSmallScreen ? 20.0 : 32.0),

              // Video section
              _buildSectionTitle(context, 'welcomeVideo', Icons.play_circle_filled, isSmallScreen),
              SizedBox(height: isSmallScreen ? 8.0 : 12.0),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: VideoPlayerWidget(
                  videoUrl: videoAssetPath,
                  title: context.tr('appIntroduction'),
                  description: context.tr('appIntroductionDesc'),
                ),
              ),
              SizedBox(height: isSmallScreen ? 20.0 : 32.0),

              // FAQ section
              _buildSectionTitle(context, 'faqTitle', Icons.question_answer, isSmallScreen),
              SizedBox(height: isSmallScreen ? 8.0 : 12.0),

              _buildFaqItem(
                context,
                'faqQuestion1',
                'faqAnswer1',
                isSmallScreen,
              ),
              const SizedBox(height: 12.0),
              _buildFaqItem(
                context,
                'faqQuestion2',
                'faqAnswer2',
                isSmallScreen,
              ),
              const SizedBox(height: 12.0),
              _buildFaqItem(
                context,
                'faqQuestion3',
                'faqAnswer3',
                isSmallScreen,
              ),
              SizedBox(height: isSmallScreen ? 20.0 : 32.0),

              // Contact support section
              _buildSectionTitle(context, 'contactSupport', Icons.email, isSmallScreen),
              SizedBox(height: isSmallScreen ? 8.0 : 12.0),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('contactSupportDesc'),
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14.0 : 16.0,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 12.0 : 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.mail_outline),
                          label: Text(context.tr('contactSupportButton')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 12.0 : 14.0,
                            ),
                          ),
                          onPressed: () {
                            // Logic to open email client or contact form
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(context.tr('comingSoon'))),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 16.0 : 24.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String key, IconData icon, bool isSmallScreen) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.primaryColor,
          size: isSmallScreen ? 20.0 : 24.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          context.tr(key),
          style: TextStyle(
            fontSize: isSmallScreen ? 16.0 : 18.0,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFaqItem(
      BuildContext context,
      String questionKey,
      String answerKey,
      bool isSmallScreen,
      ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          context.tr(questionKey),
          style: TextStyle(
            fontSize: isSmallScreen ? 15.0 : 16.0,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        collapsedIconColor: AppTheme.primaryColor,
        iconColor: AppTheme.accentColor,
        children: [
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
            child: Text(
              context.tr(answerKey),
              style: TextStyle(
                fontSize: isSmallScreen ? 14.0 : 15.0,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}