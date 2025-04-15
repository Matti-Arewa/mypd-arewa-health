//screens/kick_counter_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';

class KickCounterScreen extends StatefulWidget {
  const KickCounterScreen({Key? key}) : super(key: key);

  @override
  _KickCounterScreenState createState() => _KickCounterScreenState();
}

class _KickCounterScreenState extends State<KickCounterScreen> {
  int _kickCount = 0;
  DateTime? _startTime;
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;
  bool _isActive = false;
  List<KickSession> _pastSessions = [];

  @override
  void initState() {
    super.initState();
    // Load past sessions from provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      setState(() {
        _pastSessions = userProvider.kickSessions.cast<KickSession>();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSession() {
    setState(() {
      _kickCount = 0;
      _startTime = DateTime.now();
      _elapsedTime = Duration.zero;
      _isActive = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = DateTime.now().difference(_startTime!);
      });
    });
  }

  void _endSession() {
    _timer?.cancel();

    final endTime = DateTime.now();
    final duration = endTime.difference(_startTime!);

    final newSession = KickSession(
      count: _kickCount,
      date: _startTime!,
      duration: duration,
    );

    setState(() {
      _pastSessions.insert(0, newSession);
      _isActive = false;
    });

    // Save to user provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.addKickSession(newSession);
  }

  void _recordKick() {
    if (!_isActive) return;

    setState(() {
      _kickCount++;
    });

    // Vibrate for feedback
    // HapticFeedback.mediumImpact(); // Uncomment and import 'package:flutter/services.dart' if needed

    // Auto-end session at 10 kicks
    if (_kickCount >= 10) {
      _endSession();
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    // Responsive Einstellungen
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.tr('sessionComplete')),
        content: Text(
          context.tr('kickCounterResult', {
            'count': '10',
            'duration': _formatDuration(_elapsedTime),
          }) + "\n\n" + context.tr('expertRecommendation'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(context.tr('ok')),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    // Responsive Design-Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Responsive Größen
    final iconSize = isSmallScreen ? 50.0 : 60.0;
    final buttonHeight = isSmallScreen ? 42.0 : 48.0;
    final kickButtonSize = isSmallScreen ? 130.0 : 150.0;
    final titleFontSize = isSmallScreen ? 16.0 : 18.0;
    final bodyFontSize = isSmallScreen ? 12.0 : 14.0;
    final timerFontSize = isSmallScreen ? 28.0 : 32.0;
    final kickCountFontSize = isSmallScreen ? 42.0 : 48.0;
    final padding = isSmallScreen ? 12.0 : 16.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('kickCounter'),
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Text(
                      context.tr('kickCounter'),
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 8),
                    Text(
                      context.tr('kickCounterInstructions'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: bodyFontSize,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 18 : 24),
                    if (_isActive) ...[
                      Text(
                        _formatDuration(_elapsedTime),
                        style: TextStyle(
                          fontSize: timerFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 18 : 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_kickCount',
                            style: TextStyle(
                              fontSize: kickCountFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: isSmallScreen ? 6 : 8),
                          Text(
                            context.tr('kicks'),
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 18 : 24),
                      GestureDetector(
                        onTap: _recordKick,
                        child: Container(
                          width: kickButtonSize,
                          height: kickButtonSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryColor.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.touch_app,
                              color: Colors.white,
                              size: iconSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 18 : 24),
                      ElevatedButton(
                        onPressed: _endSession,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 10 : 12,
                              horizontal: isSmallScreen ? 20 : 24
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(context.tr('endSession')),
                      ),
                    ] else ...[
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      ElevatedButton(
                        onPressed: _startSession,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 10 : 12,
                              horizontal: isSmallScreen ? 20 : 24
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(double.infinity, buttonHeight),
                        ),
                        child: Text(context.tr('startCounting')),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? 18 : 24),
            Text(
              context.tr('pastSessions'),
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: isSmallScreen ? 6 : 8),
            _pastSessions.isEmpty
                ? Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Center(
                  child: Text(
                    context.tr('noSessionsRecorded'),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: bodyFontSize,
                    ),
                  ),
                ),
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _pastSessions.length,
              itemBuilder: (context, index) {
                final session = _pastSessions[index];
                final dateFormat = DateFormat.yMd(context.loc.locale.languageCode)
                    .add_jm(); // Uses localized date format

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: isSmallScreen ? 6 : 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      child: Text(
                        session.count.toString(),
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      context.tr('kicksInDuration', {
                        'count': '${session.count}',
                        'duration': _formatDuration(session.duration)
                      }),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 13 : 14,
                      ),
                    ),
                    subtitle: Text(
                      dateFormat.format(session.date),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: isSmallScreen ? 11 : 12,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        setState(() {
                          _pastSessions.removeAt(index);
                        });
                        // Update provider
                        final userProvider = Provider.of<UserProvider>(context, listen: false);
                        userProvider.removeKickSession(index);
                      },
                      tooltip: context.tr('delete'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}