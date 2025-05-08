import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; // Neu: Für das Öffnen externer Links
import '../providers/language_provider.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import '../services/feedback_service.dart';
import '../services/app_updates_service.dart'; // Neu: Service für App-Updates
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

  // App-Updates Status
  List<AppUpdate> _appUpdates = [];
  bool _isLoadingUpdates = true;
  String? _updatesLoadError;

  // PageView Controller für horizontales Scrollen
  final PageController _updatesPageController = PageController();
  int _currentUpdatePage = 0;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  // Services initialisieren
  Future<void> _initializeServices() async {
    try {
      if (kDebugMode) {
        print('WelcomeScreen: Initialisiere Services...');
      }

      // Initialize feedback service
      await FeedbackService.instance.initialize();

      if (kDebugMode) {
        print('WelcomeScreen: FeedbackService initialisiert, prüfe Feedback-Status...');
      }

      // Check if user has already sent feedback
      final hasSentFeedback = await FeedbackService.instance.hasUserSentFeedback();

      if (mounted) {
        setState(() {
          _feedbackSubmitted = hasSentFeedback;
          _isLoadingFeedbackStatus = false;
        });

        if (kDebugMode) {
          print('WelcomeScreen: Feedback-Status geladen. Hat Feedback gesendet: $hasSentFeedback');
        }
      }

      // App-Updates für aktuelle Sprache laden
      _loadAppUpdates();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('WelcomeScreen: Fehler beim Initialisieren der Services - $e');
        print('WelcomeScreen: Stack Trace - $stackTrace');
      }

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

  // App-Updates für aktuelle Sprache laden
  Future<void> _loadAppUpdates() async {
    if (!mounted) return;

    setState(() {
      _isLoadingUpdates = true;
      _updatesLoadError = null;
    });

    try {
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      final currentLanguage = languageProvider.currentLanguage;

      if (kDebugMode) {
        print('WelcomeScreen: Lade App-Updates für Sprache: $currentLanguage');
      }

      // App-Updates vom Service laden
      final updates = await AppUpdatesService.instance.loadUpdates(currentLanguage);

      if (mounted) {
        setState(() {
          _appUpdates = updates;
          _isLoadingUpdates = false;
          _currentUpdatePage = 0; // Zurück zum ersten Update
        });

        if (kDebugMode) {
          print('WelcomeScreen: ${updates.length} App-Updates geladen');
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('WelcomeScreen: Fehler beim Laden der App-Updates - $e');
        print('WelcomeScreen: Stack Trace - $stackTrace');
      }

      if (mounted) {
        setState(() {
          _updatesLoadError = e.toString();
          _isLoadingUpdates = false;
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Sprache hat sich möglicherweise geändert, App-Updates neu laden
    if (AppUpdatesService.instance.isLoading == false) {
      _loadAppUpdates();
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _updatesPageController.dispose();
    super.dispose();
  }

  // Externe Links öffnen
  Future<void> _openLink(String? url) async {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.tr('noLinkAvailable'))),
      );
      return;
    }

    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      if (kDebugMode) {
        print('WelcomeScreen: Fehler beim Öffnen des Links - $e');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.tr('linkError'))),
        );
      }
    }
  }

  // Function to handle friend invites
  Future<void> _inviteFriends() async {
    try {
      await Share.share(
        context.tr('inviteFriendsMessage'),
        subject: context.tr('inviteFriendsSubject'),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('WelcomeScreen: Fehler beim Teilen - $e');
        print('WelcomeScreen: Stack Trace - $stackTrace');
      }

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
      if (kDebugMode) {
        print('WelcomeScreen: Bereite Feedback-Übermittlung vor...');
      }

      // Get current language and app version
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      final currentLanguage = languageProvider.currentLanguage;

      if (kDebugMode) {
        print('WelcomeScreen: Aktuelle Sprache: $currentLanguage');
      }

      // Get app version using package_info_plus
      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';

      if (kDebugMode) {
        print('WelcomeScreen: App-Version: $appVersion');
        print('WelcomeScreen: Sende Feedback...');
      }

      // Send feedback using our service
      final result = await FeedbackService.instance.sendFeedback(
        message: _feedbackController.text.trim(),
        language: currentLanguage,
        appVersion: appVersion,
      );

      if (kDebugMode) {
        print('WelcomeScreen: Feedback-Übermittlung abgeschlossen. Ergebnis: $result');
      }

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
      if (kDebugMode) {
        print('WelcomeScreen: Fehler beim Übermitteln des Feedbacks - $e');
        print('WelcomeScreen: Stack Trace - $stackTrace');
      }

      if (mounted) {
        setState(() {
          _isSubmittingFeedback = false;
          _feedbackSuccess = false;
          _feedbackMessage = context.tr('feedbackError');
        });
      }
    }
  }

  // Seite bei Update-Karussell ändern
  void _updatePageChanged(int page) {
    setState(() {
      _currentUpdatePage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive Design-Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('welcomeTitle'),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: isSmallScreen ? 17.0 : 20.0,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        // Only show debug action in debug mode
        actions: kDebugMode ? [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Updates neu laden',
            onPressed: _loadAppUpdates,
          ),
        ] : null,
      ),
      body: RefreshIndicator(
        onRefresh: _loadAppUpdates,
        child: SingleChildScrollView(
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
                SizedBox(height: isSmallScreen ? 20.0 : 28.0),

                // NEUER ABSCHNITT: App-Updates
                _buildSectionTitle(context, 'appUpdates', isSmallScreen),
                SizedBox(height: isSmallScreen ? 8.0 : 12.0),

                // App-Updates PageView Container
                _buildAppUpdatesSection(context, isSmallScreen),
                SizedBox(height: isSmallScreen ? 24.0 : 32.0),

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
      ),
    );
  }

  // App-Updates Sektion mit PageView
  Widget _buildAppUpdatesSection(BuildContext context, bool isSmallScreen) {
    // Zeige Ladeindikator, wenn Updates geladen werden
    if (_isLoadingUpdates) {
      return Container(
        height: 320,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }

    // Zeige Fehlermeldung, wenn Fehler beim Laden
    if (_updatesLoadError != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: 240,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              context.tr('updatesLoadError'),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadAppUpdates,
              child: Text(context.tr('retry')),
            ),
          ],
        ),
      );
    }

    // Zeige Meldung, wenn keine Updates verfügbar sind
    if (_appUpdates.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: 240,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.update, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              context.tr('noUpdatesAvailable'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 14.0 : 16.0,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      );
    }

    // Höhe der Karte basierend auf Bildschirmgröße anpassen
    final cardHeight = isSmallScreen ? 320.0 : 360.0;

    return Column(
      children: [
        // PageView für horizontales Swipen durch Updates
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: _updatesPageController,
            itemCount: _appUpdates.length,
            onPageChanged: _updatePageChanged,
            itemBuilder: (context, index) {
              final update = _appUpdates[index];
              return _buildUpdateCard(context, update, isSmallScreen);
            },
          ),
        ),

        // Page Indicator
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _appUpdates.length; i++)
                Container(
                  width: i == _currentUpdatePage ? 16.0 : 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: i == _currentUpdatePage ? AppTheme.primaryColor : Colors.grey[300],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // Einzelne Update-Karte
  Widget _buildUpdateCard(BuildContext context, AppUpdate update, bool isSmallScreen) {
    // Format date based on current language
    final dateFormat = DateFormat.yMMMd(context.loc.locale.languageCode);
    final formattedDate = dateFormat.format(update.date);

    // Update-Typ Icon und Farbe bestimmen
    IconData typeIcon;
    Color typeColor;

    switch (update.type) {
      case 'feature':
        typeIcon = Icons.star;
        typeColor = Colors.amber;
        break;
      case 'bugfix':
        typeIcon = Icons.build;
        typeColor = Colors.orange;
        break;
      case 'announcement':
        typeIcon = Icons.campaign;
        typeColor = Colors.blue;
        break;
      case 'milestone':
        typeIcon = Icons.emoji_events;
        typeColor = Colors.green;
        break;
      default:
        typeIcon = Icons.info;
        typeColor = AppTheme.primaryColor;
    }

    // Optionaler Version-Badge
    Widget? versionBadge;
    if (update.version != null && update.version!.isNotEmpty) {
      versionBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          'v${update.version}',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: isSmallScreen ? 10.0 : 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area with type badge and version info
          Stack(
            children: [
              // Update image
              SizedBox(
                width: double.infinity,
                height: isSmallScreen ? 140.0 : 160.0,
                child: Image.asset(
                  update.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback-Bild bei Fehler
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Icon(typeIcon, size: 60, color: Colors.grey[400]),
                      ),
                    );
                  },
                ),
              ),

              // Update-Typ-Badge oben links
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: typeColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        typeIcon,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        context.tr('updateType_${update.type}'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Version-Badge oben rechts (falls vorhanden)
              if (versionBadge != null)
                Positioned(
                  top: 12,
                  right: 12,
                  child: versionBadge,
                ),
            ],
          ),

          // Update content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: isSmallScreen ? 12.0 : 13.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    update.title,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16.0 : 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Expanded(
                    child: Text(
                      update.description,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 13.0 : 14.0,
                        color: AppTheme.textSecondaryColor,
                        height: 1.4,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // "Mehr erfahren" Button, falls ein Link vorhanden ist
                  if (update.detailLink != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => _openLink(update.detailLink),
                        icon: const Icon(Icons.open_in_new, size: 16),
                        label: Text(context.tr('learnMore')),
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 36),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String key, bool isSmallScreen) {
    IconData icon;
    switch (key) {
      case 'appUpdates':
        icon = Icons.update;
        break;
      case 'inviteFriends':
        icon = Icons.people;
        break;
      case 'giveFeedback':
        icon = Icons.feedback;
        break;
      default:
        icon = Icons.info;
    }

    return Row(
      children: [
        Icon(
          icon,
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