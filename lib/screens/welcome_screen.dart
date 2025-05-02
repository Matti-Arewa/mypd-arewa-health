import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/language_provider.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import '../widgets/video_player_widget.dart';
import '../services/feedback_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart';

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
  bool _feedbackSubmitted = false;
  bool _isLoadingFeedbackStatus = true;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      print('WelcomeScreen: Initialisiere Services...');

      // Initialize feedback service
      await FeedbackService.instance.initialize();

      print('WelcomeScreen: FeedbackService initialisiert, prüfe Feedback-Status...');

      // Check if user has already sent feedback
      final hasSentFeedback = await FeedbackService.instance.hasUserSentFeedback();

      if (mounted) {
        setState(() {
          _feedbackSubmitted = hasSentFeedback;
          _isLoadingFeedbackStatus = false;
        });

        print('WelcomeScreen: Feedback-Status geladen. Hat Feedback gesendet: $hasSentFeedback');
      }
    } catch (e, stackTrace) {
      print('WelcomeScreen: Fehler beim Initialisieren der Services - $e');
      print('WelcomeScreen: Stack Trace - $stackTrace');

      if (mounted) {
        setState(() {
          _isLoadingFeedbackStatus = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.tr('feedbackServiceError')),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

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
    } catch (e, stackTrace) {
      print('WelcomeScreen: Fehler beim Teilen - $e');
      print('WelcomeScreen: Stack Trace - $stackTrace');

      // Show error if sharing fails
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.tr('sharingErrorMessage')),
            duration: const Duration(seconds: 5),
          ),
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

    try {
      print('WelcomeScreen: Bereite Feedback-Übermittlung vor...');

      // Get current language and app version
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      final currentLanguage = languageProvider.currentLanguage;

      print('WelcomeScreen: Aktuelle Sprache: $currentLanguage');

      // Get app version using package_info_plus
      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';

      print('WelcomeScreen: App-Version: $appVersion');
      print('WelcomeScreen: Sende Feedback...');

      // Send feedback using our service
      final result = await FeedbackService.instance.sendFeedback(
        message: _feedbackController.text.trim(),
        language: currentLanguage,
        appVersion: appVersion,
      );

      print('WelcomeScreen: Feedback-Übermittlung abgeschlossen. Ergebnis: $result');

      if (mounted) {
        setState(() {
          _isSubmittingFeedback = false;

          if (result) {
            _feedbackSuccess = true;
            _feedbackMessage = context.tr('feedbackSuccess');
            _feedbackSubmitted = true; // Mark as submitted to hide input
            _feedbackController.clear();
          } else {
            _feedbackSuccess = false;
            _feedbackMessage = context.tr('feedbackError');
          }
        });
      }
    } catch (e, stackTrace) {
      print('WelcomeScreen: Fehler beim Übermitteln des Feedbacks - $e');
      print('WelcomeScreen: Stack Trace - $stackTrace');

      if (mounted) {
        setState(() {
          _isSubmittingFeedback = false;
          _feedbackSuccess = false;
          _feedbackMessage = context.tr('feedbackError');
        });
      }
    }
  }

  // For debugging: reset feedback status
  Future<void> _resetFeedbackStatus() async {
    try {
      print('WelcomeScreen: Setze Feedback-Status zurück...');
      await FeedbackService.instance.resetFeedbackStatus();

      if (mounted) {
        setState(() {
          _feedbackSubmitted = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Feedback-Status zurückgesetzt (nur Debug)'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e, stackTrace) {
      print('WelcomeScreen: Fehler beim Zurücksetzen des Feedback-Status - $e');
      print('WelcomeScreen: Stack Trace - $stackTrace');
    }
  }

  // TEST ONLY: Simulate error to view detailed error message
  Future<void> _simulateError() async {
    try {
      print('WelcomeScreen: Simuliere Fehler...');
      throw Exception('Test-Fehler');
    } catch (e, stackTrace) {
      print('WelcomeScreen: Simulierter Fehler - $e');
      print('WelcomeScreen: Stack Trace - $stackTrace');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Simulierter Fehler: $e'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 10),
          ),
        );
      }
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
    //final String videoAssetPath = 'assets/videos/intro_${currentLanguage}.mp4';
    //Default Video
    final String videoAssetPath = 'assets/videos/intro.mp4';

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
        // Only show debug action in debug mode
        actions: kDebugMode ? [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Feedback Status (Debug)',
            onPressed: _resetFeedbackStatus,
          ),
          IconButton(
            icon: const Icon(Icons.bug_report),
            tooltip: 'Simulate Error (Debug)',
            onPressed: _simulateError,
          ),
        ] : null,
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

                      // Loading state
                      if (_isLoadingFeedbackStatus)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      // Feedback form or thank you message
                      else if (!_feedbackSubmitted) ... [
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
                      ] else ... [
                        // Thank you message after successful submission
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                context.tr('feedbackThankYou'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16.0 : 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.textPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Feedback message (error or success, if not submitted yet)
                      if (_feedbackMessage != null && !_feedbackSubmitted)
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