import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mypd_2/screens/settings_screen.dart';
import '../utils/app_theme.dart';
import '../widgets/tool_card.dart';
import '../providers/user_provider.dart';
import 'due_date_calculator_screen.dart';
import 'kick_counter_screen.dart';
import 'weight_tracker_screen.dart';
import 'nutrition_screen.dart';
import 'notes_screen.dart';
import '../services/localization_service.dart';

class ToolData {
  final String id;
  final String titleKey;
  final String descriptionKey;
  final IconData icon;
  final Color color;
  final Widget Function() screenBuilder;
  final bool isRequired;

  ToolData({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.icon,
    required this.color,
    required this.screenBuilder,
    this.isRequired = false,
  });
}

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  List<ToolData> get _availableTools => [
    ToolData(
      id: 'notes',
      titleKey: 'pregnancyNotes',
      descriptionKey: 'pregnancyNotesDesc',
      icon: Icons.note_alt,
      color: AppTheme.accentPurple,
      screenBuilder: () => const NotesScreen(),
      isRequired: true,
    ),
    ToolData(
      id: 'dueDate',
      titleKey: 'dueDateCalculator',
      descriptionKey: 'dueDateCalculatorDesc',
      icon: Icons.calendar_today,
      color: AppTheme.primaryColor,
      screenBuilder: () => const DueDateCalculatorScreen(),
    ),
    ToolData(
      id: 'kickCounter',
      titleKey: 'kickCounter',
      descriptionKey: 'kickCounterDesc',
      icon: Icons.touch_app,
      color: AppTheme.accentColor,
      screenBuilder: () => const KickCounterScreen(),
    ),
    ToolData(
      id: 'weightTracker',
      titleKey: 'weightTracker',
      descriptionKey: 'weightTrackerDesc',
      icon: Icons.monitor_weight,
      color: Colors.green,
      screenBuilder: () => const WeightTrackerScreen(),
    ),
    ToolData(
      id: 'nutrition',
      titleKey: 'nutritionGuide',
      descriptionKey: 'nutritionGuideDesc',
      icon: Icons.restaurant,
      color: Colors.orange,
      screenBuilder: () => const NutritionScreen(),
    ),
  ];

  List<ToolData> get _comingSoonTools => [
    ToolData(
      id: 'contractionTimer',
      titleKey: 'contractionTimer',
      descriptionKey: 'contractionTimerDesc',
      icon: Icons.timer,
      color: Colors.grey,
      screenBuilder: () => const Scaffold(),
    ),
    ToolData(
      id: 'babyNameExplorer',
      titleKey: 'babyNameExplorer',
      descriptionKey: 'babyNameExplorerDesc',
      icon: Icons.child_care,
      color: Colors.grey,
      screenBuilder: () => const Scaffold(),
    ),
  ];

  void _showPersonalizationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PersonalizationBottomSheet(tools: _availableTools),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Adjust sizes based on screen size
    final titleFontSize = isSmallScreen ? 18.0 : 22.0;
    final subtitleFontSize = isSmallScreen ? 12.0 : 14.0;
    final sectionTitleFontSize = isSmallScreen ? 16.0 : 20.0;
    final padding = isSmallScreen ? 12.0 : 16.0;
    final spacing = isSmallScreen ? 8.0 : 16.0;
    final sectionSpacing = isSmallScreen ? 24.0 : 32.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('pregnancyTools'),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: isSmallScreen ? 18.0 : 20.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () => _showPersonalizationBottomSheet(context),
            tooltip: context.tr('personalizeTools'),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            tooltip: context.tr('settings'),
          ),
        ],
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final enabledToolIds = userProvider.enabledToolIds;
          final enabledTools = _availableTools.where((tool) =>
          tool.isRequired || enabledToolIds.contains(tool.id)
          ).toList();

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section with personalization hint
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr('interactiveTools'),
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: titleFontSize,
                            ),
                          ),
                          SizedBox(height: spacing / 2),
                          Text(
                            context.tr('toolsDescription'),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: subtitleFontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.tune,
                          color: AppTheme.primaryColor,
                          size: isSmallScreen ? 20 : 24,
                        ),
                        onPressed: () => _showPersonalizationBottomSheet(context),
                        tooltip: context.tr('personalizeTools'),
                      ),
                    ),
                  ],
                ),

                // Info box for personalization if some tools are hidden
                if (enabledTools.length < _availableTools.length) ...[
                  SizedBox(height: spacing),
                  Container(
                    padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                    decoration: BoxDecoration(
                      color: AppTheme.accentBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.accentBlue.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppTheme.accentBlue,
                          size: isSmallScreen ? 16 : 20,
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 12),
                        Expanded(
                          child: Text(
                            context.tr('personalizedToolsInfo'),
                            style: TextStyle(
                              color: AppTheme.accentBlue,
                              fontSize: isSmallScreen ? 11 : 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: spacing * 1.5),

                // Show enabled tools
                ...enabledTools.map((tool) => Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: ToolCard(
                    title: context.tr(tool.titleKey),
                    description: context.tr(tool.descriptionKey),
                    icon: tool.icon,
                    color: tool.color,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => tool.screenBuilder(),
                        ),
                      );
                    },
                  ),
                )),

                // Coming Soon Section
                if (_comingSoonTools.isNotEmpty) ...[
                  SizedBox(height: sectionSpacing),
                  Text(
                    context.tr('comingSoon'),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: sectionTitleFontSize,
                    ),
                  ),
                  SizedBox(height: spacing),
                  ..._comingSoonTools.map((tool) => Padding(
                    padding: EdgeInsets.only(bottom: spacing),
                    child: ToolCard(
                      title: context.tr(tool.titleKey),
                      description: context.tr(tool.descriptionKey),
                      icon: tool.icon,
                      color: Colors.grey,
                      isDisabled: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(context.tr('featureComingSoon')),
                          ),
                        );
                      },
                    ),
                  )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PersonalizationBottomSheet extends StatefulWidget {
  final List<ToolData> tools;

  const _PersonalizationBottomSheet({required this.tools});

  @override
  State<_PersonalizationBottomSheet> createState() => _PersonalizationBottomSheetState();
}

class _PersonalizationBottomSheetState extends State<_PersonalizationBottomSheet> {
  late Set<String> _selectedTools;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _selectedTools = Set.from(userProvider.enabledToolIds);

    // Ensure all required tools are selected
    for (final tool in widget.tools) {
      if (tool.isRequired) {
        _selectedTools.add(tool.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final isSmallScreen = screenWidth < 360;

    return Container(
      height: screenHeight * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            child: Column(
              children: [
                Text(
                  context.tr('personalizeYourTools'),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 6 : 8),
                Text(
                  context.tr('selectToolsToShow'),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Tools list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20),
              itemCount: widget.tools.length,
              itemBuilder: (context, index) {
                final tool = widget.tools[index];
                final isSelected = _selectedTools.contains(tool.id);
                final isRequired = tool.isRequired;

                return Container(
                  margin: EdgeInsets.only(bottom: isSmallScreen ? 8 : 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? tool.color.withOpacity(0.3)
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected
                        ? tool.color.withOpacity(0.05)
                        : Colors.white,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 16,
                      vertical: isSmallScreen ? 6 : 8,
                    ),
                    leading: Container(
                      padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                      decoration: BoxDecoration(
                        color: tool.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        tool.icon,
                        color: tool.color,
                        size: isSmallScreen ? 20 : 24,
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr(tool.titleKey),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: isSmallScreen ? 14 : 16,
                            ),
                          ),
                        ),
                        if (isRequired)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 6 : 8,
                              vertical: isSmallScreen ? 2 : 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              context.tr('required'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 9 : 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        context.tr(tool.descriptionKey),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                    ),
                    trailing: isRequired
                        ? Icon(
                      Icons.lock,
                      color: Colors.grey[400],
                      size: isSmallScreen ? 18 : 20,
                    )
                        : Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _selectedTools.add(tool.id);
                          } else {
                            _selectedTools.remove(tool.id);
                          }
                        });
                      },
                      activeColor: tool.color,
                    ),
                    onTap: isRequired ? null : () {
                      setState(() {
                        if (_selectedTools.contains(tool.id)) {
                          _selectedTools.remove(tool.id);
                        } else {
                          _selectedTools.add(tool.id);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Bottom actions
          Container(
            padding: EdgeInsets.fromLTRB(
                isSmallScreen ? 16 : 20,
                isSmallScreen ? 12 : 16,
                isSmallScreen ? 16 : 20,
                (isSmallScreen ? 16 : 20) + bottomPadding
            ),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                top: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 10 : 12,
                      ),
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      context.tr('cancel'),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: isSmallScreen ? 13 : 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 8 : 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .updateEnabledTools(_selectedTools.toList());
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.tr('toolsUpdated')),
                          backgroundColor: AppTheme.primaryColor,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 10 : 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      context.tr('saveChanges'),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isSmallScreen ? 13 : 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}