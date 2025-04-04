//widgets/language_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class LanguageSelector extends StatelessWidget {
  // List of supported languages with their locale codes and display names
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'de', 'name': 'Deutsch (German)'},
    {'code': 'fr', 'name': 'Français (French)'},
    {'code': 'sw', 'name': 'Kiswahili (Swahili)'},
    {'code': 'ha', 'name': 'Hausa'},
    {'code': 'yo', 'name': 'Yorùbá (Yoruba)'},
    {'code': 'am', 'name': 'አማርኛ (Amharic)'},
    {'code': 'ig', 'name': 'Igbo'},
  ];

  LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final currentLanguage = settingsProvider.settings.language;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Language',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Select your preferred language for the app content',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                final isSelected = language['code'] == currentLanguage;

                return ListTile(
                  title: Text(language['name']!),
                  trailing: isSelected
                      ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  )
                      : null,
                  onTap: () {
                    settingsProvider.setLanguage(language['code']!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Language changed to ${language['name']}',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}