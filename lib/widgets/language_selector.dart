//widgets/language_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../services/localization_service.dart';

class LanguageSelector extends StatelessWidget {
  // List of supported languages with their locale codes and display names
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'de', 'name': 'Deutsch'},
  ];

  LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;

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
              context.tr('language'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              context.tr('selectLanguage'),
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
                    languageProvider.changeLanguage(language['code']!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          context.tr('language') + ' ' +
                              context.tr('changed') + ': ' +
                              language['name']!,
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