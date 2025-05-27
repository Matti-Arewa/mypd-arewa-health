// screens/language_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import 'intro_video_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {

  String _selectedLanguage = 'en';
  String _selectedRegion = 'int';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
  ];

  final List<Map<String, String>> _regions = [
    {'code': 'int', 'name': 'International', 'flag': '🌍'},
    {'code': 'de', 'name': 'Deutschland', 'flag': '🇩🇪'},
    {'code': 'fr', 'name': 'France', 'flag': '🇫🇷'},
  ];

  @override
  void initState() {
    super.initState();

    // Get current language and region from providers
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _selectedLanguage = userProvider.language;
    _selectedRegion = userProvider.region;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _continueToNextScreen() async {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Update language and region
    await languageProvider.changeLanguage(_selectedLanguage);
    userProvider.language = _selectedLanguage;
    userProvider.region = _selectedRegion;

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IntroVideoScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360 || size.height < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor.withOpacity(0.1),
              AppTheme.backgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 20.0 : 24.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: isSmallScreen ? 20 : 40),

                        // Header
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.language,
                                    size: isSmallScreen ? 40 : 50,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                SizedBox(height: isSmallScreen ? 16 : 24),
                                Text(
                                  context.tr('selectLanguageAndRegion'),
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 22 : 26,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: isSmallScreen ? 8 : 12),
                                Text(
                                  context.tr('languageSelectionSubtitle'),
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 30 : 40),

                        // Language Selection
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr('selectLanguage'),
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 18 : 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimaryColor,
                                  ),
                                ),
                                SizedBox(height: isSmallScreen ? 12 : 16),

                                ..._languages.map((language) => _buildLanguageOption(
                                  language['code']!,
                                  language['name']!,
                                  language['flag']!,
                                  isSmallScreen,
                                )),

                                SizedBox(height: isSmallScreen ? 24 : 32),

                                // Region Selection
                                Text(
                                  context.tr('selectRegion'),
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 18 : 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimaryColor,
                                  ),
                                ),
                                SizedBox(height: isSmallScreen ? 12 : 16),

                                ..._regions.map((region) => _buildRegionOption(
                                  region['code']!,
                                  region['name']!,
                                  region['flag']!,
                                  isSmallScreen,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Continue Button
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: isSmallScreen ? 16 : 20,
                        bottom: isSmallScreen ? 8 : 12,
                      ),
                      child: ElevatedButton(
                        onPressed: _continueToNextScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: isSmallScreen ? 14 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          context.tr('continue'),
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String code, String name, String flag, bool isSmallScreen) {
    final isSelected = _selectedLanguage == code;

    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 8 : 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedLanguage = code;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppTheme.primaryColor : AppTheme.dividerColor,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  flag,
                  style: TextStyle(fontSize: isSmallScreen ? 20 : 24),
                ),
                SizedBox(width: isSmallScreen ? 12 : 16),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimaryColor,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: AppTheme.primaryColor,
                    size: isSmallScreen ? 20 : 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegionOption(String code, String name, String flag, bool isSmallScreen) {
    final isSelected = _selectedRegion == code;

    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 8 : 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedRegion = code;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.accentColor.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppTheme.accentColor : AppTheme.dividerColor,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  flag,
                  style: TextStyle(fontSize: isSmallScreen ? 20 : 24),
                ),
                SizedBox(width: isSmallScreen ? 12 : 16),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppTheme.accentColor : AppTheme.textPrimaryColor,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: AppTheme.accentColor,
                    size: isSmallScreen ? 20 : 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}