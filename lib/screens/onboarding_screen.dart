import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../screens/home_screen.dart';
import '../widgets/due_date_picker.dart';
import '../services/localization_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;
  bool _dueDateSet = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    Provider.of<UserProvider>(context, listen: false).setFirstLaunchComplete();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _onDueDateSelected(DateTime date) {
    Provider.of<UserProvider>(context, listen: false).setDueDate(date);
    setState(() {
      _dueDateSet = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsives Design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    final titleFontSize = isSmallScreen ? 20.0 : 22.0;
    final bodyFontSize = isSmallScreen ? 14.0 : 16.0;
    final padding = isSmallScreen ? 16.0 : 20.0;
    final spacing = isSmallScreen ? 20.0 : 30.0;
    final imageHeight = isSmallScreen ? 150.0 : 200.0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildWelcomePage(titleFontSize, bodyFontSize, padding, spacing, imageHeight),
                  _buildDueDatePage(titleFontSize, bodyFontSize, padding, spacing, imageHeight),
                  _buildFeaturePage(titleFontSize, bodyFontSize, padding, spacing),
                ],
              ),
            ),
            _buildPageIndicator(),
            _buildBottomButtons(isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage(double titleSize, double bodySize, double padding, double spacing, double imageHeight) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/welcome.png',
            height: imageHeight,
          ),
          SizedBox(height: spacing),
          Text(
            context.tr('welcomeTitle'),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: titleSize,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr('welcomeSubtitle'),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: bodySize,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDueDatePage(double titleSize, double bodySize, double padding, double spacing, double imageHeight) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/calendar.jpg',
            height: imageHeight,
          ),
          SizedBox(height: spacing / 1.5),
          Text(
            context.tr('dueDateQuestion'),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: titleSize,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr('dueDateExplanation'),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: bodySize,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spacing / 1.5),
          DueDatePicker(
            onDateSelected: _onDueDateSelected,
            initialDate: Provider.of<UserProvider>(context).dueDate,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePage(double titleSize, double bodySize, double padding, double spacing) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: spacing / 2),
          Text(
            context.tr('featuresTitle'),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: titleSize,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spacing),
          _buildFeatureItem(
              Icons.search,
              context.tr('featureInfoTitle'),
              context.tr('featureInfoDescription'),
              bodySize
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(
              Icons.notifications,
              context.tr('featureRemindersTitle'),
              context.tr('featureRemindersDescription'),
              bodySize
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(
              Icons.favorite,
              context.tr('featureTrackersTitle'),
              context.tr('featureTrackersDescription'),
              bodySize
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description, double fontSize) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: fontSize,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  fontSize: fontSize - 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _totalPages,
              (index) =>
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 16.0 : 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: _currentPage == 0
                ? null
                : () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Text(_currentPage == 0 ? '' : context.tr('back')),
          ),
          ElevatedButton(
            onPressed: _currentPage == 1 && !_dueDateSet ? null : _goToNextPage,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 24 : 32,
                  vertical: isSmallScreen ? 10 : 12
              ),
            ),
            child: Text(
                _currentPage == _totalPages - 1
                    ? context.tr('getStarted')
                    : context.tr('next')
            ),
          ),
        ],
      ),
    );
  }
}