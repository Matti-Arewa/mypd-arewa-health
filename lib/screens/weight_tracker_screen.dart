import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/custom_app_bar.dart';

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
        const SnackBar(content: Text('Weight entry saved')),
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
    return Scaffold(
      appBar: const CustomAppBar(title: 'Weight Tracker'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            final weightEntries = userProvider.weightEntries;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User guidance text
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Track Your Weight',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Regular weight monitoring during pregnancy helps ensure healthy growth for both mother and baby. Consult your healthcare provider about ideal weight gain.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Weight input form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Entry',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date field
                          Expanded(
                            child: TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                labelText: 'Date',
                                prefixIcon: const Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              readOnly: true,
                              onTap: () => _selectDate(context),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Weight field
                          Expanded(
                            child: TextFormField(
                              controller: _weightController,
                              decoration: InputDecoration(
                                labelText: 'Weight (kg)',
                                prefixIcon: const Icon(Icons.monitor_weight_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter weight';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveWeight,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Save Entry'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Weight chart section
                if (weightEntries.isNotEmpty) ...[
                  Text(
                    'Weight Progress',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 240,
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
                                  return SideTitleWidget(
                                    meta: meta,
                                    child: Text(
                                      DateFormat('MM/dd').format(weightEntries[value.toInt()].date),
                                      style: const TextStyle(fontSize: 10),
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
                                    '${value.toInt()} kg',
                                    style: const TextStyle(fontSize: 10),
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
                                  radius: 4,
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
                        const SizedBox(height: 32),
                        Icon(
                          Icons.show_chart,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No weight entries yet',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add your first entry to start tracking',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 32),

                // Weight history list
                if (weightEntries.isNotEmpty) ...[
                  Text(
                    'Weight History',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: weightEntries.length,
                    itemBuilder: (context, index) {
                      final entry = weightEntries[index];
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
                            const SnackBar(content: Text('Entry deleted')),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 8),
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
                              '${entry.weight} kg',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              DateFormat('EEEE, MMMM d, yyyy').format(entry.date),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                userProvider.removeWeightEntry(entry);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Entry deleted')),
                                );
                              },
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