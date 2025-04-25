import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/language_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/localization_service.dart';

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

  @override
  void initState() {
    super.initState();
    _loadSettings();
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    return WillPopScope(
      // Verwende WillPopScope, um sicherzustellen, dass die Navigation korrekt funktioniert
      onWillPop: () async {
        Navigator.of(context).pop();
        return false; // Gib false zurück, um die Standard-Zurück-Navigation zu unterdrücken
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.tr('settings'),
          backgroundColor: AppTheme.primaryColor,
          showBackButton: true,
          onBackPressed: () {
            // Explizite Navigation zurück
            Navigator.of(context).pop();
          },
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionHeader(context.tr('generalSettings')),
            _buildSettingItem(
              icon: Icons.language,
              title: context.tr('language'),
              subtitle: languageProvider.getLanguageName(_language),
              onTap: () => _showLanguageDialog(),
            ),
            _buildSettingItem(
              icon: Icons.location_on_outlined,
              title: context.tr('region'),
              subtitle: _getRegionName(_region),
              onTap: () => _showRegionDialog(),
            ),
            const Divider(),

            _buildSectionHeader(context.tr('notifications')),
            _buildSwitchItem(
              icon: Icons.notifications_outlined,
              title: context.tr('pushNotifications'),
              subtitle: context.tr('notificationsSubtitle'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                Provider.of<UserProvider>(context, listen: false).notificationsEnabled = value;
              },
            ),
            const Divider(),

            _buildSectionHeader(context.tr('units')),
            _buildSwitchItem(
              icon: Icons.thermostat_outlined,
              title: context.tr('temperature'),
              subtitle: context.tr('temperatureSubtitle'),
              value: _useCelsius,
              onChanged: (value) {
                setState(() {
                  _useCelsius = value;
                });
                Provider.of<UserProvider>(context, listen: false).useCelsius = value;
              },
            ),
            const Divider(),

            _buildSectionHeader(context.tr('account')),
            _buildSettingItem(
              icon: Icons.person_outline,
              title: context.tr('profile'),
              subtitle: context.tr('profileSubtitle'),
              onTap: () {
                // Navigate to profile screen
                // This will be implemented in future versions
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.tr('comingSoon'))),
                );
              },
            ),
            _buildSettingItem(
              icon: Icons.security_outlined,
              title: context.tr('dataPrivacy'),
              subtitle: context.tr('dataPrivacySubtitle'),
              onTap: () {
                // Navigate to privacy settings
                // This will be implemented in future versions
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.tr('comingSoon'))),
                );
              },
            ),
            const Divider(),

            _buildSectionHeader(context.tr('about')),
            _buildSettingItem(
              icon: Icons.help_outline,
              title: context.tr('help'),
              subtitle: context.tr('helpSubtitle'),
              onTap: () {
                // Navigate to help screen
                // This will be implemented in future versions
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.tr('comingSoon'))),
                );
              },
            ),
            _buildSettingItem(
              icon: Icons.info_outline,
              title: context.tr('aboutTitle'),
              subtitle: context.tr('aboutSubtitle'),
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
                    SnackBar(content: Text(context.tr('comingSoon'))),
                  );
                },
                child: Text(
                  context.tr('signOut'),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: AppTheme.fontSizeBodyLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
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

  String _getRegionName(String code) {
    // Use localized region names
    return context.tr('region_$code');
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.tr('selectLanguage')),
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
            child: Text(context.tr('close')),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String code, String name) {
    return ListTile(
      title: Text(name),
      trailing: _language == code ? const Icon(Icons.check, color: AppTheme.primaryColor) : null,
      onTap: () async {
        setState(() {
          _language = code;
        });

        // Update UserProvider
        Provider.of<UserProvider>(context, listen: false).language = code;

        // Update LanguageProvider to change app-wide language
        await Provider.of<LanguageProvider>(context, listen: false).changeLanguage(code);

        Navigator.of(context).pop();
      },
    );
  }

  void _showRegionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.tr('selectRegion')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRegionOption('int', _getRegionName('int')),
            _buildRegionOption('de', _getRegionName('de')),
            //_buildRegionOption('at', _getRegionName('at')),
            //_buildRegionOption('ch', _getRegionName('ch')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('close')),
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
        title: Text(context.tr('aboutTitle')),
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
              context.tr('appDescription'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: AppTheme.fontSizeBodyMedium),
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('copyright'),
              style: const TextStyle(fontSize: AppTheme.fontSizeSmall),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('close')),
          ),
        ],
      ),
    );
  }
}