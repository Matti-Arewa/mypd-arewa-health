import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;
  late bool _notificationsEnabled;
  late bool _useCelsius;
  late String _language;
  late String _region;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      _isDarkMode = userProvider.isDarkMode;
      _notificationsEnabled = userProvider.notificationsEnabled;
      _useCelsius = userProvider.useCelsius;
      _language = userProvider.language;
      _region = userProvider.region;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('General Settings'),
          _buildSettingItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: _getLanguageName(_language),
            onTap: () => _showLanguageDialog(),
          ),
          _buildSettingItem(
            icon: Icons.location_on_outlined,
            title: 'Region',
            subtitle: _getRegionName(_region),
            onTap: () => _showRegionDialog(),
          ),
          _buildSwitchItem(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Change app appearance',
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
              Provider.of<UserProvider>(context, listen: false).isDarkMode = value;
            },
          ),
          const Divider(),
          _buildSectionHeader('Notifications'),
          _buildSwitchItem(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            subtitle: 'Receive pregnancy updates and reminders',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              Provider.of<UserProvider>(context, listen: false).notificationsEnabled = value;
            },
          ),
          const Divider(),
          _buildSectionHeader('Units'),
          _buildSwitchItem(
            icon: Icons.thermostat_outlined,
            title: 'Temperature',
            subtitle: 'Use Celsius instead of Fahrenheit',
            value: _useCelsius,
            onChanged: (value) {
              setState(() {
                _useCelsius = value;
              });
              Provider.of<UserProvider>(context, listen: false).useCelsius = value;
            },
          ),
          const Divider(),
          _buildSectionHeader('Account'),
          _buildSettingItem(
            icon: Icons.person_outline,
            title: 'Profile',
            subtitle: 'Edit your personal information',
            onTap: () {
              // Navigate to profile screen
              // This will be implemented in future versions
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile feature coming in a future update')),
              );
            },
          ),
          _buildSettingItem(
            icon: Icons.security_outlined,
            title: 'Data Privacy',
            subtitle: 'Manage your data and privacy settings',
            onTap: () {
              // Navigate to privacy settings
              // This will be implemented in future versions
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy settings coming in a future update')),
              );
            },
          ),
          const Divider(),
          _buildSectionHeader('About'),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'Help',
            subtitle: 'Get assistance and support',
            onTap: () {
              // Navigate to help screen
              // This will be implemented in future versions
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help center coming in a future update')),
              );
            },
          ),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'App version and information',
            onTap: () {
              _showAboutDialog();
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () {
                // Implement logout functionality
                // This will be implemented in future versions
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout functionality coming in a future update')),
                );
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'fr':
        return 'French';
      case 'de':
        return 'German';
      case 'sw':
        return 'Swahili';
      default:
        return 'English';
    }
  }

  String _getRegionName(String code) {
    switch (code) {
      case 'de':
        return 'Germany';
      case 'ke':
        return 'Kenya';
      case 'ng':
        return 'Nigeria';
      case 'gh':
        return 'Ghana';
      default:
        return 'International';
    }
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('en', 'English'),
            _buildLanguageOption('fr', 'French'),
            _buildLanguageOption('de', 'German'),
            _buildLanguageOption('sw', 'Swahili'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String code, String name) {
    return ListTile(
      title: Text(name),
      trailing: _language == code ? const Icon(Icons.check, color: AppTheme.primaryColor) : null,
      onTap: () {
        setState(() {
          _language = code;
        });
        Provider.of<UserProvider>(context, listen: false).language = code;
        Navigator.of(context).pop();
      },
    );
  }

  void _showRegionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Region'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRegionOption('int', 'International'),
            _buildRegionOption('de', 'Germany'),
            _buildRegionOption('ke', 'Kenya'),
            _buildRegionOption('ng', 'Nigeria'),
            _buildRegionOption('gh', 'Ghana'),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionOption(String code, String name) {
    return ListTile(
      title: Text(name),
      trailing: _region == code ? const Icon(Icons.check, color: AppTheme.primaryColor) : null,
      onTap: () {
        setState(() {
          _region = code;
        });
        Provider.of<UserProvider>(context, listen: false).region = code;
        Navigator.of(context).pop();
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('About'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.pregnant_woman,
                size: 50,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'AREWA Health App',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Version 1.0.0'),
            const SizedBox(height: 16),
            const Text(
              'A comprehensive pregnancy resource app designed to provide valuable information and tools for expectant mothers.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              '© 2025 AREWA Health App',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}