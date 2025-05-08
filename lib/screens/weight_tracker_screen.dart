import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/localization_service.dart';

class WeightTrackerScreen extends StatefulWidget {
  static const routeName = '/weight-tracker';

  const WeightTrackerScreen({super.key});

  @override
  State<WeightTrackerScreen> createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _selectedMonth;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
  }

  @override
  void dispose() {
    _weightController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryColor,
              onPrimary: Colors.white,
              onSurface: AppTheme.textPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
      });
    }
  }

  void _saveWeight() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<UserProvider>(context, listen: false);

      provider.addWeightEntry(
        date: _selectedDate,
        weight: double.parse(_weightController.text),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.tr('weightEntrySaved'))),
      );

      _weightController.clear();
      setState(() {
        _selectedDate = DateTime.now();
        _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);

        // Update selected month when adding a new entry
        final monthYearFormatter = DateFormat('MMMM yyyy', context.loc.locale.languageCode);
        _selectedMonth = monthYearFormatter.format(_selectedDate);
      });
    }
  }

  // Get a list of available months from entries
  List<String> _getAvailableMonths(List<WeightEntry> entries) {
    if (entries.isEmpty) return [];

    final monthYearFormatter = DateFormat('MMMM yyyy', context.loc.locale.languageCode);
    final Set<String> months = {};

    for (var entry in entries) {
      months.add(monthYearFormatter.format(entry.date));
    }

    // Sort months in descending order (newest first)
    final sortedMonths = months.toList()
      ..sort((a, b) {
        // Parse month strings back to DateTime for comparison
        final aDate = DateFormat('MMMM yyyy', context.loc.locale.languageCode).parse(a);
        final bDate = DateFormat('MMMM yyyy', context.loc.locale.languageCode).parse(b);
        return bDate.compareTo(aDate); // Descending order
      });

    return sortedMonths;
  }

  // Filter entries for the selected month
  List<WeightEntry> _getEntriesForMonth(List<WeightEntry> allEntries, String month) {
    if (allEntries.isEmpty || month.isEmpty) return [];

    final monthYearFormatter = DateFormat('MMMM yyyy', context.loc.locale.languageCode);
    final targetDate = monthYearFormatter.parse(month);
    final targetYear = targetDate.year;
    final targetMonth = targetDate.month;

    return allEntries.where((entry) {
      return entry.date.year == targetYear && entry.date.month == targetMonth;
    }).toList()
    // Sort by date - oldest to newest
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Adjust sizes based on screen size
    final titleFontSize = isSmallScreen ? 16.0 : 18.0;
    final bodyFontSize = isSmallScreen ? 12.0 : 14.0;
    final sectionTitleFontSize = isSmallScreen ? 15.0 : 16.0;
    final listTileTitleFontSize = isSmallScreen ? 14.0 : 16.0;
    final listTileSubtitleFontSize = isSmallScreen ? 12.0 : 13.0;
    final padding = isSmallScreen ? 12.0 : 16.0;
    final spacing = isSmallScreen ? 12.0 : 16.0;
    final chartHeight = isSmallScreen ? 200.0 : 240.0;
    final placeholderIconSize = isSmallScreen ? 48.0 : 64.0;
    final dropdownHeight = isSmallScreen ? 40.0 : 48.0;

    return Scaffold(
      appBar: CustomAppBar(title: context.tr('weightTracker'), backgroundColor: AppTheme.primaryColor, titleColor: Colors.white,titleFontWeight: FontWeight.w600,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            final allWeightEntries = userProvider.weightEntries;
            // Get weight unit from user settings
            final weightUnit = context.tr('kg');

            // Get available months
            final availableMonths = _getAvailableMonths(allWeightEntries);

            // Initialize selected month if not set and entries exist
            if (_selectedMonth == null && availableMonths.isNotEmpty) {
              _selectedMonth = availableMonths.first;
            }

            // Get entries for selected month
            final monthlyEntries = _selectedMonth != null ?
            _getEntriesForMonth(allWeightEntries, _selectedMonth!) : [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User guidance text
                Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('trackYourWeight'),
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: titleFontSize,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 6 : 8),
                      Text(
                        context.tr('weightTrackerDescription'),
                        style: TextStyle(fontSize: bodyFontSize),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing * 1.5),

                // Weight input form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('addNewEntry'),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: sectionTitleFontSize,
                        ),
                      ),
                      SizedBox(height: spacing),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date field
                          Expanded(
                            child: TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                labelText: context.tr('date'),
                                prefixIcon: const Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              readOnly: true,
                              onTap: () => _selectDate(context),
                            ),
                          ),
                          SizedBox(width: isSmallScreen ? 12 : 16),
                          // Weight field
                          Expanded(
                            child: TextFormField(
                              controller: _weightController,
                              decoration: InputDecoration(
                                labelText: context.tr('weightWithUnit', {'unit': weightUnit}),
                                prefixIcon: const Icon(Icons.monitor_weight_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.tr('pleaseEnterWeight');
                                }
                                if (double.tryParse(value) == null) {
                                  return context.tr('pleaseEnterValidNumber');
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveWeight,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 10 : 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(context.tr('saveEntry')),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing * 2),

                // Weight chart section
                if (allWeightEntries.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr('weightProgress'),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: sectionTitleFontSize,
                        ),
                      ),
                      // Month selection dropdown
                      Container(
                        height: dropdownHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedMonth,
                            icon: const Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
                            elevation: 16,
                            style: TextStyle(
                              color: AppTheme.textPrimaryColor,
                              fontSize: bodyFontSize,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedMonth = newValue;
                              });
                            },
                            items: availableMonths
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text(
                              context.tr('selectMonth'),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: bodyFontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),

                  if (monthlyEntries.isNotEmpty) ...[
                    Container(
                      height: chartHeight,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Date range display
                          if (monthlyEntries.length > 1)
                            Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 8),
                              child: Text(
                                '${DateFormat.MMMd(context.loc.locale.languageCode).format(monthlyEntries.first.date)} - ${DateFormat.MMMd(context.loc.locale.languageCode).format(monthlyEntries.last.date)}',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 10 : 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),

                          // The chart
                          Expanded(
                            child: LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: false),
                                titlesData: FlTitlesData(
                                  bottomTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 40,
                                      getTitlesWidget: (double value, TitleMeta meta) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: Text(
                                            '${value.toInt()} $weightUnit',
                                            style: TextStyle(fontSize: isSmallScreen ? 8 : 10),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(color: const Color(0xff37434d), width: 1),
                                ),
                                minX: 0,
                                maxX: monthlyEntries.length - 1.0,
                                minY: monthlyEntries.map((e) => e.weight).reduce((min, e) => e < min ? e : min) - 1,
                                maxY: monthlyEntries.map((e) => e.weight).reduce((max, e) => e > max ? e : max) + 1,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: List.generate(
                                      monthlyEntries.length,
                                          (index) => FlSpot(index.toDouble(), monthlyEntries[index].weight),
                                    ),
                                    isCurved: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppTheme.primaryColor.withOpacity(0.7),
                                        AppTheme.accentColor,
                                      ],
                                    ),
                                    barWidth: 3,
                                    isStrokeCapRound: true,
                                    dotData: FlDotData(
                                      show: true,
                                      getDotPainter: (spot, percent, barData, index) {
                                        return FlDotCirclePainter(
                                          radius: isSmallScreen ? 3 : 4,
                                          color: AppTheme.primaryColor,
                                          strokeWidth: 2,
                                          strokeColor: Colors.white,
                                        );
                                      },
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppTheme.primaryColor.withOpacity(0.2),
                                          AppTheme.accentColor.withOpacity(0.1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Container(
                      height: chartHeight,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          context.tr('noEntriesForMonth'),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: bodyFontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ] else ...[
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: spacing * 2),
                        Icon(
                          Icons.show_chart,
                          size: placeholderIconSize,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: spacing),
                        Text(
                          context.tr('noWeightEntries'),
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.grey[600],
                            fontSize: sectionTitleFontSize,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 6 : 8),
                        Text(
                          context.tr('addFirstEntry'),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: bodyFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spacing * 2),

                // Weight history list
                if (allWeightEntries.isNotEmpty) ...[
                  Text(
                    context.tr('weightHistory'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: sectionTitleFontSize,
                    ),
                  ),
                  SizedBox(height: spacing),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allWeightEntries.length,
                    itemBuilder: (context, index) {
                      // Sort entries by date in descending order (newest first)
                      final sortedEntries = List<WeightEntry>.from(allWeightEntries)
                        ..sort((a, b) => b.date.compareTo(a.date));

                      final entry = sortedEntries[index];
                      // Use localized date format
                      final dateFormat = DateFormat.yMMMMEEEEd(context.loc.locale.languageCode);

                      return Dismissible(
                        key: Key(entry.date.toIso8601String()),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          userProvider.removeWeightEntry(entry);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(context.tr('entryDeleted'))),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.only(bottom: isSmallScreen ? 6 : 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                              child: const Icon(
                                Icons.monitor_weight_outlined,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            title: Text(
                              '${entry.weight} $weightUnit',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: listTileTitleFontSize,
                              ),
                            ),
                            subtitle: Text(
                              dateFormat.format(entry.date),
                              style: TextStyle(fontSize: listTileSubtitleFontSize),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                userProvider.removeWeightEntry(entry);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(context.tr('entryDeleted'))),
                                );
                              },
                              tooltip: context.tr('delete'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}