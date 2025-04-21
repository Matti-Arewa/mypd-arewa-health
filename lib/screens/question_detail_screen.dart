//screens/question_detail.screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/related_questions.dart';
import '../services/localization_service.dart';

class QuestionDetailScreen extends StatelessWidget {
  final ContentQuestion question;
  final String categoryId;

  const QuestionDetailScreen({
    super.key,
    required this.question,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final category = contentProvider.getCategoryById(categoryId);

    // Responsive Design-Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Responsive Textstile basierend auf Bildschirmgröße
    final titleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      color: AppTheme.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: isSmallScreen ? 18.0 : 22.0,
    );

    final bodyStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: isSmallScreen ? 14.0 : 16.0,
      height: 1.4, // Verbesserte Zeilenhöhe für bessere Lesbarkeit
    );

    final sectionTitleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: AppTheme.primaryColor,
      fontSize: isSmallScreen ? 16.0 : 18.0,
      fontWeight: FontWeight.w600,
    );

    // Responsive Abstände
    final padding = isSmallScreen ? 12.0 : 16.0;
    final spacing = isSmallScreen ? 16.0 : 20.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category?.title ?? context.tr('question'),
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: isSmallScreen ? 18.0 : 20.0,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              contentProvider.isFavorite(question.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: AppTheme.accentColor,
            ),
            onPressed: () {
              contentProvider.toggleFavorite(question.id);
            },
            tooltip: context.tr('toggleFavorite'),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: AppTheme.accentColor),
            onPressed: () {
              // Share functionality could be implemented here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.tr('sharingComingSoon'))),
              );
            },
            tooltip: context.tr('share'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Bereich mit Bild und Titel
            //_buildHeaderSection(context, question, category, titleStyle, isSmallScreen),

            // Hauptinhalt
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kategorienavi (neu)
                  _buildBreadcrumbNavigation(context, contentProvider, category, isSmallScreen),
                  SizedBox(height: spacing),

                  // Antwortinhalt
                  _buildAnswerContent(question.answer, bodyStyle),
                  SizedBox(height: spacing),

                  // Medienbereich (falls vorhanden)
                  if (question.mediaUrls.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('visualGuide'),
                          style: sectionTitleStyle,
                        ),
                        SizedBox(height: isSmallScreen ? 8 : 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildMediaWidget(question.mediaUrls, isSmallScreen),
                        ),
                      ],
                    ),
                  SizedBox(height: isSmallScreen ? 24 : 32),

                  // Verwandte Fragen
                  Text(
                    context.tr('relatedQuestions'),
                    style: sectionTitleStyle,
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 16),
                  RelatedQuestions(
                    currentQuestionId: question.id,
                    categoryId: categoryId,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Neuer Header-Bereich mit optionalem Hintergrundbild
  Widget _buildHeaderSection(BuildContext context, ContentQuestion question, ContentCategory? category, TextStyle? titleStyle, bool isSmallScreen) {
    // Überprüfen, ob ein Bild verfügbar ist
    final hasHeaderImage = question.mediaUrls.isNotEmpty && !question.mediaUrls.first.endsWith('.mp4');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        // Hintergrundbild, falls vorhanden
        image: hasHeaderImage ? DecorationImage(
          image: AssetImage(question.mediaUrls.first),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ) : null,
      ),
      padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kategorie-Chip
          if (category != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: hasHeaderImage ? Colors.white.withOpacity(0.8) : AppTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category.title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 12.0 : 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),

          SizedBox(height: 12),

          // Frage-Titel
          Text(
            question.question,
            style: titleStyle?.copyWith(
              color: hasHeaderImage ? Colors.white : AppTheme.primaryColor,
              shadows: hasHeaderImage ? [
                Shadow(
                  offset: const Offset(0, 1),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ] : null,
            ),
          ),

          SizedBox(height: isSmallScreen ? 8 : 12),
        ],
      ),
    );
  }

  // Breadcrumb-Navigation zur besseren Orientierung
  Widget _buildBreadcrumbNavigation(BuildContext context, ContentProvider contentProvider, ContentCategory? category, bool isSmallScreen) {
    if (category == null) return const SizedBox.shrink();

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.menu_book,
          size: isSmallScreen ? 14 : 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          context.tr('guide'),
          style: TextStyle(
            fontSize: isSmallScreen ? 12 : 13,
            color: Colors.grey[600],
          ),
        ),
        Icon(
          Icons.chevron_right,
          size: isSmallScreen ? 14 : 16,
          color: Colors.grey[600],
        ),
        Text(
          category.title,
          style: TextStyle(
            fontSize: isSmallScreen ? 12 : 13,
            fontWeight: FontWeight.w500,
            color: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }

  // Formatierter Antworttext mit Hervorhebungen
  Widget _buildAnswerContent(String answer, TextStyle? bodyStyle) {
    // Liste-Erkennung: Zeilen, die mit • oder - beginnen
    final List<String> paragraphs = answer.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((paragraph) {
        // Prüfen, ob es sich um eine Liste handelt
        if (paragraph.contains('\n• ') || paragraph.contains('\n- ')) {
          final listItems = paragraph.split('\n');
          final listHeader = listItems[0]; // Die erste Zeile ist der Header

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Liste-Header
              if (listHeader.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    listHeader,
                    style: bodyStyle?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),

              // Liste-Items
              ...listItems.skip(1).where((item) => item.trim().isNotEmpty).map((item) {
                final isListItem = item.trim().startsWith('• ') || item.trim().startsWith('- ');
                if (isListItem) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '•',
                          style: bodyStyle?.copyWith(
                            fontSize: (bodyStyle.fontSize ?? 16) + 2,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.replaceFirst(RegExp(r'^\s*[•\-]\s*'), ''),
                            style: bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(item, style: bodyStyle),
                  );
                }
              }).toList(),
            ],
          );
        } else {
          // Normale Absätze
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(paragraph, style: bodyStyle),
          );
        }
      }).toList(),
    );
  }

  Widget _buildMediaWidget(List<String> mediaUrls, bool isSmallScreen) {
    final mediaUrl = mediaUrls.first;
    if (mediaUrl.endsWith('.mp4')) {
      return Container(
        height: isSmallScreen ? 160 : 200,
        color: Colors.grey[300],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_circle_outline, size: isSmallScreen ? 40 : 48, color: AppTheme.primaryColor),
              const SizedBox(height: 8),
              Text(
                'Video content', //Error
                //context.tr('videoContent'),
                style: TextStyle(fontSize: isSmallScreen ? 13.0 : 14.0),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        constraints: BoxConstraints(
          maxHeight: isSmallScreen ? 200 : 250,
        ),
        child: Image.asset(
          mediaUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/placeholder.png',
              fit: BoxFit.cover,
            );
          },
        ),
      );
    }
  }
}