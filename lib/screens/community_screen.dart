//screens/community_screen.dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import 'dart:math' as math;

class CommunityPost {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String content;
  final DateTime postedAt;
  final int likesCount;
  final int commentsCount;
  final List<String> tags;
  final bool isExpert;

  CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.postedAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.tags = const [],
    this.isExpert = false,
  });
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  bool _isComposing = false;
  final TextEditingController _postController = TextEditingController();

  // Mock-Daten für den Prototyp
  final List<CommunityPost> _posts = [
    CommunityPost(
      id: '1',
      authorName: 'Laura M.',
      authorAvatar: 'assets/images/avatar1.png',
      content: 'Hat jemand Tipps gegen Sodbrennen in der 32. Woche? Ich habe schon alles versucht!',
      postedAt: DateTime.now().subtract(const Duration(hours: 3)),
      likesCount: 8,
      commentsCount: 5,
      tags: ['Sodbrennen', 'Drittes Trimester'],
    ),
    CommunityPost(
      id: '2',
      authorName: 'Julia K.',
      authorAvatar: 'assets/images/avatar2.png',
      content: 'Heute den ersten Tritt gespürt! So ein wunderschönes Gefühl. ❤️',
      postedAt: DateTime.now().subtract(const Duration(hours: 5)),
      likesCount: 24,
      commentsCount: 7,
      tags: ['Babybewegungen', 'Zweites Trimester'],
    ),
    CommunityPost(
      id: '3',
      authorName: 'Sarah P.',
      authorAvatar: 'assets/images/avatar3.png',
      content: 'Welche Kliniktasche habt ihr für die Geburt gepackt? Ich bin im 8. Monat und möchte langsam anfangen, alles vorzubereiten.',
      postedAt: DateTime.now().subtract(const Duration(hours: 8)),
      likesCount: 15,
      commentsCount: 12,
      tags: ['Kliniktasche', 'Geburtsvorbereitung'],
    ),
    CommunityPost(
      id: '4',
      authorName: 'Melanie H.',
      authorAvatar: 'assets/images/avatar4.png',
      content: 'Hat jemand Erfahrung mit Pränataldiagnostik? Ich stehe vor der Entscheidung, ob ich Tests machen lassen soll.',
      postedAt: DateTime.now().subtract(const Duration(hours: 10)),
      likesCount: 6,
      commentsCount: 8,
      tags: ['Pränataldiagnostik', 'Vorsorge'],
    ),
    CommunityPost(
      id: '5',
      authorName: 'Martina B.',
      authorAvatar: 'assets/images/avatar5.png',
      content: 'Ist es normal, dass ich im ersten Trimester so erschöpft bin? Ich schlafe fast 10 Stunden täglich und bin trotzdem müde.',
      postedAt: DateTime.now().subtract(const Duration(hours: 24)),
      likesCount: 18,
      commentsCount: 9,
      tags: ['Müdigkeit', 'Erstes Trimester'],
    ),
  ];

  final List<CommunityPost> _expertPosts = [
    CommunityPost(
      id: 'e1',
      authorName: 'Dr. Martina Schmidt',
      authorAvatar: 'assets/images/doctor1.png',
      content: 'Liebe werdende Mütter, denkt daran, ausreichend Folsäure zu euch zu nehmen. Dies ist besonders wichtig für die Entwicklung des Neuralrohrs beim Baby in den ersten Wochen der Schwangerschaft.',
      postedAt: DateTime.now().subtract(const Duration(days: 1)),
      likesCount: 45,
      commentsCount: 12,
      tags: ['Expertenrat', 'Ernährung'],
      isExpert: true,
    ),
    CommunityPost(
      id: 'e2',
      authorName: 'Hebamme Sabine Weber',
      authorAvatar: 'assets/images/midwife1.png',
      content: 'Entspannungstechniken für die Geburt: Praktiziert regelmäßig tiefe Atemübungen. Sie können helfen, während der Wehen ruhig zu bleiben und euren Körper mit Sauerstoff zu versorgen. Übt verschiedene Positionen, die euch während der Wehen helfen können, bequemer zu sein.',
      postedAt: DateTime.now().subtract(const Duration(days: 2)),
      likesCount: 38,
      commentsCount: 8,
      tags: ['Geburtsvorbereitung', 'Entspannung'],
      isExpert: true,
    ),
  ];

  // Liste von Kategorien für Filter
  final List<String> _categories = [
    'Alle Beiträge',
    'Erstes Trimester',
    'Zweites Trimester',
    'Drittes Trimester',
    'Ernährung',
    'Bewegung',
    'Geburtsvorbereitung',
    'Medizinische Fragen'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Diskussionen'),
            Tab(text: 'Expertenrat'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      body: Column(
        children: [
          // Suchfeld und Filter
          _buildSearchBar(),

          // Filter-Chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(_categories[index]),
                    selected: index == 0, // Standardmäßig "Alle Beiträge" ausgewählt
                    onSelected: (selected) {
                      // Hier später Filterlogik implementieren
                    },
                    backgroundColor: Colors.white,
                    selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: index == 0 ? AppTheme.primaryColor : AppTheme.textPrimaryColor,
                      fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // Tab-Inhalte
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Diskussionen-Tab
                _buildPostsList(_posts),

                // Expertenrat-Tab
                _buildPostsList(_expertPosts),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showComposeDialog();
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add_comment, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'In der Community suchen...',
          prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, color: AppTheme.primaryColor),
            onPressed: () {
              setState(() {
                _searchController.clear();
              });
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppTheme.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          // Hier später Suchlogik implementieren
          setState(() {});
        },
      ),
    );
  }

  Widget _buildPostsList(List<CommunityPost> posts) {
    if (posts.isEmpty) {
      return const Center(
        child: Text('Keine Beiträge gefunden'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return _buildPostCard(post);
      },
    );
  }

  Widget _buildPostCard(CommunityPost post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          _showPostDetailDialog(post);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Autor-Informationen
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: _getRandomColor(post.id),
                    child: Text(
                      post.authorName.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.authorName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (post.isExpert) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.accentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Experte',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        _formatPostTime(post.postedAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Beitragsinhalt
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  post.content,
                  style: const TextStyle(fontSize: 15),
                ),
              ),

              // Tags
              if (post.tags.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  children: post.tags.map((tag) {
                    return Chip(
                      label: Text(
                        '#$tag',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
              ],

              // Interaktionen
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up_outlined),
                    color: AppTheme.accentColor,
                    onPressed: () {
                      // Like-Logik hier implementieren
                    },
                  ),
                  Text('${post.likesCount}'),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined),
                    color: AppTheme.primaryColor,
                    onPressed: () {
                      _showPostDetailDialog(post);
                    },
                  ),
                  Text('${post.commentsCount}'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {
                      // Lesezeichen-Logik hier implementieren
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComposeDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Neuer Beitrag',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _postController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Teilen Sie Ihre Erfahrungen oder stellen Sie eine Frage...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {
                        _isComposing = text.isNotEmpty;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image, color: AppTheme.primaryColor),
                        onPressed: () {
                          // Foto-Upload-Logik hier implementieren
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.tag, color: AppTheme.primaryColor),
                        onPressed: () {
                          // Tag-Hinzufügen-Logik hier implementieren
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _isComposing
                            ? () {
                          // Beitrag-Veröffentlichen-Logik hier implementieren
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ihr Beitrag wurde veröffentlicht'),
                              backgroundColor: AppTheme.primaryColor,
                            ),
                          );
                          Navigator.pop(context);
                          _postController.clear();
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey[300],
                        ),
                        child: const Text('Veröffentlichen'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showPostDetailDialog(CommunityPost post) {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Ziehbalken
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Beitragsdetails
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        // Original-Beitrag
                        _buildPostCard(post),

                        // Kommentare-Überschrift
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            'Kommentare (${post.commentsCount})',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),

                        // Kommentare (Beispielkommentare)
                        _buildCommentCard(
                          'Maria S.',
                          'Ich habe ähnliche Erfahrungen gemacht. Versuche mal, kleinere Mahlzeiten zu dir zu nehmen und vor dem Schlafengehen nichts mehr zu essen.',
                          DateTime.now().subtract(const Duration(hours: 1)),
                        ),
                        _buildCommentCard(
                          'Claudia W.',
                          'Mandelmilch hat bei mir gegen Sodbrennen geholfen. Vielleicht ist das einen Versuch wert?',
                          DateTime.now().subtract(const Duration(hours: 2)),
                        ),
                      ],
                    ),
                  ),

                  // Kommentar-Eingabefeld
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: 'Kommentar schreiben...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: AppTheme.primaryColor,
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: () {
                              if (commentController.text.isNotEmpty) {
                                // Kommentar-Senden-Logik hier implementieren
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Ihr Kommentar wurde veröffentlicht'),
                                    backgroundColor: AppTheme.primaryColor,
                                  ),
                                );
                                commentController.clear();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCommentCard(String authorName, String content, DateTime postedAt) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: _getRandomColor(authorName),
                  child: Text(
                    authorName.substring(0, 1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  authorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatPostTime(postedAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.thumb_up_outlined, size: 16),
                  label: const Text('Gefällt mir'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () {
                    // Like-Logik implementieren
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatPostTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Gerade eben';
    } else if (difference.inHours < 1) {
      return 'Vor ${difference.inMinutes} ${difference.inMinutes == 1 ? 'Minute' : 'Minuten'}';
    } else if (difference.inDays < 1) {
      return 'Vor ${difference.inHours} ${difference.inHours == 1 ? 'Stunde' : 'Stunden'}';
    } else if (difference.inDays < 7) {
      return 'Vor ${difference.inDays} ${difference.inDays == 1 ? 'Tag' : 'Tagen'}';
    } else {
      return '${dateTime.day}.${dateTime.month}.${dateTime.year}';
    }
  }

  Color _getRandomColor(String seed) {
    // Deterministische Farbe basierend auf der ID
    final random = math.Random(seed.hashCode);

    // Verschiedene ruhige und medizinisch anmutende Farben
    final colors = [
      const Color(0xFF5C6BC0), // Indigo
      const Color(0xFF26A69A), // Teal
      const Color(0xFF42A5F5), // Blue
      const Color(0xFF7E57C2), // Deep Purple
      const Color(0xFF66BB6A), // Green
      AppTheme.primaryColor,
      AppTheme.accentColor,
    ];

    return colors[random.nextInt(colors.length)];
  }
}