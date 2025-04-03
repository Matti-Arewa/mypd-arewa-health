import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../screens/home_screen.dart';
import '../widgets/due_date_picker.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

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
                  _buildWelcomePage(),
                  _buildDueDatePage(),
                  _buildFeaturePage(),
                ],
              ),
            ),
            _buildPageIndicator(),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/welcome.png',
            height: 200,
          ),
          const SizedBox(height: 40),
          Text(
            'Welcome to Pregnancy Guide',
            style: Theme
                .of(context)
                .textTheme
                .displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Your comprehensive companion through your pregnancy journey',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDueDatePage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/calendar.png',
            height: 150,
          ),
          const SizedBox(height: 30),
          Text(
            'When is your baby due?',
            style: Theme
                .of(context)
                .textTheme
                .displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'This helps us provide you with the most relevant information and track your pregnancy journey.',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          DueDatePicker(
            onDateSelected: _onDueDateSelected,
            initialDate: Provider
                .of<UserProvider>(context)
                .dueDate,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/features.png',
            height: 180,
          ),
          const SizedBox(height: 30),
          Text(
            'Features Designed for You',
            style: Theme
                .of(context)
                .textTheme
                .displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildFeatureItem(
              Icons.search,
              'Comprehensive Information',
              'Access reliable pregnancy information anytime, anywhere'
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(
              Icons.notifications,
              'Timely Reminders',
              'Get notifications about important milestones'
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(
              Icons.favorite,
              'Pregnancy Trackers',
              'Track your pregnancy progress with useful tools'
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .primaryColor
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme
                .of(context)
                .primaryColor,
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
                style: Theme
                    .of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                  color: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(0.7),
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
                      ? Theme
                      .of(context)
                      .primaryColor
                      : Theme
                      .of(context)
                      .primaryColor
                      .withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
            child: Text(_currentPage == 0 ? '' : 'Back'),
          ),
          ElevatedButton(
            onPressed: _currentPage == 1 && !_dueDateSet ? null : _goToNextPage,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(
                _currentPage == _totalPages - 1 ? 'Get Started' : 'Next'),
          ),
        ],
      ),
    );
  }
}