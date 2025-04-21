import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/language_provider.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import '../widgets/video_player_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _feedbackController = TextEditingController();
  bool _isSubmittingFeedback = false;
  String? _feedbackMessage;
  bool _feedbackSuccess = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  // Function to handle friend invites
  Future<void> _inviteFriends() async {
    try {
      await Share.share(
        context.tr('inviteFriendsMessage'),
        subject: context.tr('inviteFriendsSubject'),
      );
    } catch (e) {
      // Show error if sharing fails
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.tr('sharingErrorMessage'))),
        );
      }
    }
  }

  // Function to submit feedback
  Future<void> _submitFeedback() async {
    // Validate feedback
    if (_feedbackController.text.trim().isEmpty) {
      setState(() {
        _feedbackMessage = context.tr('feedbackEmpty');
        _feedbackSuccess = false;
      });
      return;
    }

    // Show loading state
    setState(() {
      _isSubmittingFeedback = true;
      _feedbackMessage = null;
    });

    // Simulate network request
    await Future.delayed(const Duration(seconds: 1));

    // For now, we'll just simulate a successful submission
    // In a real app, you would send this to your backend
    if (mounted) {
      setState(() {
        _isSubmittingFeedback = false;
        _feedbackMessage = context.tr('feedbackSuccess');
        _feedbackSuccess = true;
        _feedbackController.clear();
      });

      // Clear success message after a few seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _feedbackMessage = null;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;

    // Responsive Design-Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Get video asset path based on language
    final String videoAssetPath = 'assets/videos/intro_${currentLanguage}.mp4';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('welcomeTitle'),
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: isSmallScreen ? 18.0 : 20.0,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              Text(
                context.tr('welcomeSubtitle'),
                style: TextStyle(
                  fontSize: isSmallScreen ? 16.0 : 18.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              SizedBox(height: isSmallScreen ? 16.0 : 24.0),

              // Video section
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

              // Invite friends section
              _buildSectionTitle(context, 'inviteFriends', isSmallScreen),
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
                        context.tr('inviteFriendsDesc'),
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14.0 : 16.0,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 12.0 : 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.share),
                          label: Text(context.tr('shareWithFriends')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 12.0 : 14.0,
                            ),
                          ),
                          onPressed: _inviteFriends,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 20.0 : 32.0),

              // Feedback section
              _buildSectionTitle(context, 'giveFeedback', isSmallScreen),
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
                        context.tr('feedbackDesc'),
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14.0 : 16.0,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 12.0 : 16.0),

                      // Feedback text field
                      TextField(
                        controller: _feedbackController,
                        decoration: InputDecoration(
                          hintText: context.tr('feedbackHint'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        maxLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      SizedBox(height: isSmallScreen ? 12.0 : 16.0),

                      // Submit button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isSubmittingFeedback ? null : _submitFeedback,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 12.0 : 14.0,
                            ),
                          ),
                          child: _isSubmittingFeedback
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Text(context.tr('submitFeedback')),
                        ),
                      ),

                      // Feedback message
                      if (_feedbackMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            _feedbackMessage!,
                            style: TextStyle(
                              color: _feedbackSuccess ? Colors.green : Colors.red,
                              fontSize: isSmallScreen ? 13.0 : 14.0,
                            ),
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

  Widget _buildSectionTitle(BuildContext context, String key, bool isSmallScreen) {
    return Row(
      children: [
        Icon(
          key == 'inviteFriends' ? Icons.people : Icons.feedback,
          color: AppTheme.primaryColor,
          size: isSmallScreen ? 20.0 : 24.0,
        ),
        SizedBox(width: 8.0),
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
}