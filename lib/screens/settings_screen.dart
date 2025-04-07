//screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _notificationsEnabled;
  late bool _useCelsius;
  late String _language;
  late String _region;

  // Texte für Mehrsprachigkeit
  late Map<String, Map<String, String>> _translations;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _initTranslations();
  }

  void _initTranslations() {
    _translations = {
      'en': {
        'settings': 'Settings',
        'generalSettings': 'General Settings',
        'language': 'Language',
        'region': 'Region',
        'notifications': 'Notifications',
        'pushNotifications': 'Push Notifications',
        'notificationsSubtitle': 'Receive pregnancy updates and reminders',
        'units': 'Units',
        'temperature': 'Temperature',
        'temperatureSubtitle': 'Use Celsius instead of Fahrenheit',
        'account': 'Account',
        'profile': 'Profile',
        'profileSubtitle': 'Edit your personal information',
        'dataPrivacy': 'Data Privacy',
        'dataPrivacySubtitle': 'Manage your data and privacy settings',
        'about': 'About',
        'help': 'Help',
        'helpSubtitle': 'Get assistance and support',
        'aboutTitle': 'About',
        'aboutSubtitle': 'App version and information',
        'signOut': 'Sign Out',
        'comingSoon': 'Coming in a future update',
        'selectLanguage': 'Select Language',
        'selectRegion': 'Select Region',
        'close': 'Close',
      },
      'de': {
        'settings': 'Einstellungen',
        'generalSettings': 'Allgemeine Einstellungen',
        'language': 'Sprache',
        'region': 'Region',
        'notifications': 'Benachrichtigungen',
        'pushNotifications': 'Push-Benachrichtigungen',
        'notificationsSubtitle': 'Schwangerschaftsupdates und Erinnerungen erhalten',
        'units': 'Einheiten',
        'temperature': 'Temperatur',
        'temperatureSubtitle': 'Celsius statt Fahrenheit verwenden',
        'account': 'Konto',
        'profile': 'Profil',
        'profileSubtitle': 'Persönliche Informationen bearbeiten',
        'dataPrivacy': 'Datenschutz',
        'dataPrivacySubtitle': 'Daten- und Datenschutzeinstellungen verwalten',
        'about': 'Über',
        'help': 'Hilfe',
        'helpSubtitle': 'Unterstützung und Hilfe erhalten',
        'aboutTitle': 'Über die App',
        'aboutSubtitle': 'App-Version und Informationen',
        'signOut': 'Abmelden',
        'comingSoon': 'In einem zukünftigen Update verfügbar',
        'selectLanguage': 'Sprache auswählen',
        'selectRegion': 'Region auswählen',
        'close': 'Schließen',
      }
    };
  }

  void _loadSettings() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      _notificationsEnabled = userProvider.notificationsEnabled;
      _useCelsius = userProvider.useCelsius;
      _language = userProvider.language;
      _region = userProvider.region;
    });
  }

  // Hilfsfunktion für Übersetzungen
  String _t(String key) {
    return _translations[_language]?[key] ?? _translations['en']![key]!;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: _t('settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Due Date Section

          _buildSectionHeader(_t('generalSettings')),
          _buildSettingItem(
            icon: Icons.language,
            title: _t('language'),
            subtitle: _getLanguageName(_language),
            onTap: () => _showLanguageDialog(),
          ),
          _buildSettingItem(
            icon: Icons.location_on_outlined,
            title: _t('region'),
            subtitle: _getRegionName(_region),
            onTap: () => _showRegionDialog(),
          ),
          const Divider(),

          _buildSectionHeader(_t('notifications')),
          _buildSwitchItem(
            icon: Icons.notifications_outlined,
            title: _t('pushNotifications'),
            subtitle: _t('notificationsSubtitle'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              Provider.of<UserProvider>(context, listen: false).notificationsEnabled = value;
            },
          ),
          const Divider(),

          _buildSectionHeader(_t('units')),
          _buildSwitchItem(
            icon: Icons.thermostat_outlined,
            title: _t('temperature'),
            subtitle: _t('temperatureSubtitle'),
            value: _useCelsius,
            onChanged: (value) {
              setState(() {
                _useCelsius = value;
              });
              Provider.of<UserProvider>(context, listen: false).useCelsius = value;
            },
          ),
          const Divider(),

          _buildSectionHeader(_t('account')),
          _buildSettingItem(
            icon: Icons.person_outline,
            title: _t('profile'),
            subtitle: _t('profileSubtitle'),
            onTap: () {
              // Navigate to profile screen
              // This will be implemented in future versions
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(_t('comingSoon'))),
              );
            },
          ),
          _buildSettingItem(
            icon: Icons.security_outlined,
            title: _t('dataPrivacy'),
            subtitle: _t('dataPrivacySubtitle'),
            onTap: () {
              // Navigate to privacy settings
              // This will be implemented in future versions
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(_t('comingSoon'))),
              );
            },
          ),
          const Divider(),

          _buildSectionHeader(_t('about')),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: _t('help'),
            subtitle: _t('helpSubtitle'),
            onTap: () {
              // Navigate to help screen
              // This will be implemented in future versions
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(_t('comingSoon'))),
              );
            },
          ),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: _t('aboutTitle'),
            subtitle: _t('aboutSubtitle'),
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
                  SnackBar(content: Text(_t('comingSoon'))),
                );
              },
              child: Text(
                _t('signOut'),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: AppTheme.fontSizeBodyLarge,
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
          fontSize: AppTheme.fontSizeBodyLarge,
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
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeBodyLarge,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeBodyMedium,
        ),
      ),
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
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeBodyLarge,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeBodyMedium,
        ),
      ),
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
      case 'de':
        return 'Deutsch';
      default:
        return 'English';
    }
  }

  String _getRegionName(String code) {
    // Übersetzungen für die Regionen basierend auf der aktuellen Sprache
    if (_language == 'de') {
      switch (code) {
        case 'de':
          return 'Deutschland';
        case 'at':
          return 'Österreich';
        case 'ch':
          return 'Schweiz';
        default:
          return 'International';
      }
    } else {
      switch (code) {
        case 'de':
          return 'Germany';
        case 'at':
          return 'Austria';
        case 'ch':
          return 'Switzerland';
        default:
          return 'International';
      }
    }
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_t('selectLanguage')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('en', 'English'),
            _buildLanguageOption('de', 'Deutsch'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(_t('close')),
          ),
        ],
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
        title: Text(_t('selectRegion')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRegionOption('int', _getRegionName('int')),
            _buildRegionOption('de', _getRegionName('de')),
            _buildRegionOption('at', _getRegionName('at')),
            _buildRegionOption('ch', _getRegionName('ch')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(_t('close')),
          ),
        ],
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
        title: Text(_t('aboutTitle')),
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
              'Pregnancy Guide App',
              style: TextStyle(
                fontSize: AppTheme.fontSizeDisplaySmall,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Version 1.0.0'),
            const SizedBox(height: 16),
            Text(
              _language == 'de'
                  ? 'Eine umfassende App für Schwangere, die wertvolle Informationen und Tools für werdende Mütter bietet.'
                  : 'A comprehensive pregnancy resource app designed to provide valuable information and tools for expectant mothers.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: AppTheme.fontSizeBodyMedium),
            ),
            const SizedBox(height: 16),
            const Text(
              '© 2025 Pregnancy Guide App',
              style: TextStyle(fontSize: AppTheme.fontSizeSmall),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(_t('close')),
          ),
        ],
      ),
    );
  }
}