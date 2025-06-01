import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import '../providers/user_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  String _selectedCategory = 'general';

  @override
  void dispose() {
    _noteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _showAddNoteDialog() {
    _noteController.clear();
    _titleController.clear();
    _selectedCategory = 'general';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(context.tr('addNewNote')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: context.tr('noteTitle'),
                    hintText: context.tr('noteTitleHint'),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: context.tr('category'),
                  ),
                  items: [
                    DropdownMenuItem(value: 'general', child: Text(context.tr('categoryGeneral'))),
                    DropdownMenuItem(value: 'doctor', child: Text(context.tr('categoryDoctor'))),
                    DropdownMenuItem(value: 'symptoms', child: Text(context.tr('categorySymptoms'))),
                    DropdownMenuItem(value: 'questions', child: Text(context.tr('categoryQuestions'))),
                    DropdownMenuItem(value: 'baby', child: Text(context.tr('categoryBaby'))),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: context.tr('noteContent'),
                    hintText: context.tr('noteContentHint'),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.tr('cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.trim().isNotEmpty &&
                    _noteController.text.trim().isNotEmpty) {
                  Provider.of<UserProvider>(context, listen: false).addNote(
                    title: _titleController.text.trim(),
                    content: _noteController.text.trim(),
                    category: _selectedCategory,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text(context.tr('save')),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditNoteDialog(PregnancyNote note) {
    _titleController.text = note.title;
    _noteController.text = note.content;
    _selectedCategory = note.category;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(context.tr('editNote')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: context.tr('noteTitle'),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: context.tr('category'),
                  ),
                  items: [
                    DropdownMenuItem(value: 'general', child: Text(context.tr('categoryGeneral'))),
                    DropdownMenuItem(value: 'doctor', child: Text(context.tr('categoryDoctor'))),
                    DropdownMenuItem(value: 'symptoms', child: Text(context.tr('categorySymptoms'))),
                    DropdownMenuItem(value: 'questions', child: Text(context.tr('categoryQuestions'))),
                    DropdownMenuItem(value: 'baby', child: Text(context.tr('categoryBaby'))),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: context.tr('noteContent'),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.tr('cancel')),
            ),
            TextButton(
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).removeNote(note);
                Navigator.of(context).pop();
              },
              child: Text(context.tr('delete'), style: const TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.trim().isNotEmpty &&
                    _noteController.text.trim().isNotEmpty) {
                  Provider.of<UserProvider>(context, listen: false).updateNote(
                    note,
                    title: _titleController.text.trim(),
                    content: _noteController.text.trim(),
                    category: _selectedCategory,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text(context.tr('save')),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'doctor':
        return AppTheme.accentBlue;
      case 'symptoms':
        return AppTheme.accentOrange;
      case 'questions':
        return AppTheme.accentPurple;
      case 'baby':
        return AppTheme.accentPink;
      default:
        return AppTheme.accentGreen;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'doctor':
        return Icons.local_hospital;
      case 'symptoms':
        return Icons.healing;
      case 'questions':
        return Icons.help_outline;
      case 'baby':
        return Icons.child_care;
      default:
        return Icons.note;
    }
  }

  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'general':
        return context.tr('categoryGeneral');
      case 'doctor':
        return context.tr('categoryDoctor');
      case 'symptoms':
        return context.tr('categorySymptoms');
      case 'questions':
        return context.tr('categoryQuestions');
      case 'baby':
        return context.tr('categoryBaby');
      default:
        return context.tr('categoryGeneral');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final padding = isSmallScreen ? 12.0 : 16.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('pregnancyNotes'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final notes = userProvider.pregnancyNotes;

          if (notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.tr('noNotesYet'),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.tr('addFirstNote'),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(padding),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final categoryColor = _getCategoryColor(note.category);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _showEditNoteDialog(note),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: categoryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _getCategoryIcon(note.category),
                                color: categoryColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    _getCategoryDisplayName(note.category),
                                    style: TextStyle(
                                      color: categoryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              _formatDate(note.createdAt),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          note.content,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return context.tr('today');
    } else if (difference.inDays == 1) {
      return context.tr('yesterday');
    } else if (difference.inDays < 7) {
      return context.tr('daysAgo').replaceAll('{days}', difference.inDays.toString());
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }
}