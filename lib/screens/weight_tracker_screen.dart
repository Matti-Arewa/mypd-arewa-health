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

  const WeightTrackerScreen({Key? key}) : super(key: key);

  @override
  State<WeightTrackerScreen> createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
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
            colorScheme: ColorScheme.light(
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
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
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
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
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

    return Scaffold(
      appBar: CustomAppBar(title: context.tr('weightTracker')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            final weightEntries = userProvider.weightEntries;
            // Get weight unit from user settings
            final weightUnit = context.tr('kg');

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
                if (weightEntries.isNotEmpty) ...[
                  Text(
                    context.tr('weightProgress'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: sectionTitleFontSize,
                    ),
                  ),
                  SizedBox(height: spacing),
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
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                if (value.toInt() >= 0 && value.toInt() < weightEntries.length) {
                                  // Use localized date format
                                  final dateFormat = DateFormat.MMMd(context.loc.locale.languageCode);
                                  return SideTitleWidget(
                                    meta: meta,
                                    child: Text(
                                      dateFormat.format(weightEntries[value.toInt()].date),
                                      style: TextStyle(fontSize: isSmallScreen ? 8 : 10),
                                    ),
                                  );
                                }
                                return SideTitleWidget(
                                  meta: meta,
                                  child: Text(''),
                                );
                              },
                            ),
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
                        maxX: weightEntries.length - 1.0,
                        minY: weightEntries.map((e) => e.weight).reduce((min, e) => e < min ? e : min) - 2,
                        maxY: weightEntries.map((e) => e.weight).reduce((max, e) => e > max ? e : max) + 2,
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(
                              weightEntries.length,
                                  (index) => FlSpot(index.toDouble(), weightEntries[index].weight),
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
                if (weightEntries.isNotEmpty) ...[
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
                    itemCount: weightEntries.length,
                    itemBuilder: (context, index) {
                      final entry = weightEntries[index];
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