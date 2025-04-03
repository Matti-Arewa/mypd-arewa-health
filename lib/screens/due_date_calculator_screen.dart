import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';

class DueDateCalculatorScreen extends StatefulWidget {
  const DueDateCalculatorScreen({super.key});

  @override
  _DueDateCalculatorScreenState createState() => _DueDateCalculatorScreenState();
}

class _DueDateCalculatorScreenState extends State<DueDateCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  DateTime? _dueDate;
  int? _weeksPregnant;
  int? _daysPregnant;
  String? _trimester;

  @override
  void initState() {
    super.initState();
    // Try to load saved date from user provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.lastPeriodDate != null) {
        setState(() {
          _selectedDate = userProvider.lastPeriodDate;
          _calculateDueDate();
        });
      }
    });
  }

  void _calculateDueDate() {
    if (_selectedDate == null) return;

    // Naegele's rule: Add 1 year, subtract 3 months, add 7 days
    final dueDate = DateTime(
      _selectedDate!.year + 1,
      _selectedDate!.month - 3,
      _selectedDate!.day + 7,
    );

    // Calculate weeks pregnant
    final today = DateTime.now();
    final difference = today.difference(_selectedDate!).inDays;
    final weeksPregnant = difference ~/ 7;
    final daysPregnant = difference % 7;

    // Determine trimester
    String trimester;
    if (weeksPregnant < 13) {
      trimester = '1st Trimester';
    } else if (weeksPregnant < 27) {
      trimester = '2nd Trimester';
    } else {
      trimester = '3rd Trimester';
    }

    setState(() {
      _dueDate = dueDate;
      _weeksPregnant = weeksPregnant;
      _daysPregnant = daysPregnant;
      _trimester = trimester;
    });

    // Save to user provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setDueDate(dueDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().subtract(const Duration(days: 30)),
      firstDate: DateTime.now().subtract(const Duration(days: 280)),
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
        _calculateDueDate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Due Date Calculator',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'When did your last menstrual period start?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppTheme.primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'Select date'
                                    : DateFormat('MMMM d, yyyy').format(_selectedDate!),
                                style: TextStyle(
                                  color: _selectedDate == null
                                      ? Colors.grey
                                      : AppTheme.textPrimaryColor,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: AppTheme.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_selectedDate != null)
                        ElevatedButton(
                          onPressed: _calculateDueDate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: const Text('Calculate Due Date'),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_dueDate != null) ...[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Your Due Date',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          DateFormat('MMMM d, yyyy').format(_dueDate!),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildInfoRow('Weeks pregnant', '$_weeksPregnant weeks, $_daysPregnant days'),
                        const SizedBox(height: 8),
                        _buildInfoRow('Trimester', _trimester!),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          'Progress',
                          '${((_weeksPregnant! * 7 + _daysPregnant!) / 280 * 100).toStringAsFixed(1)}%',
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: (_weeksPregnant! * 7 + _daysPregnant!) / 280,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Important Dates',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDateRow(
                          'First Trimester',
                          DateFormat('MMM d').format(_selectedDate!),
                          ' - ',
                          DateFormat('MMM d').format(_selectedDate!.add(const Duration(days: 7 * 13))),
                        ),
                        const SizedBox(height: 8),
                        _buildDateRow(
                          'Second Trimester',
                          DateFormat('MMM d').format(_selectedDate!.add(const Duration(days: 7 * 13 + 1))),
                          ' - ',
                          DateFormat('MMM d').format(_selectedDate!.add(const Duration(days: 7 * 26))),
                        ),
                        const SizedBox(height: 8),
                        _buildDateRow(
                          'Third Trimester',
                          DateFormat('MMM d').format(_selectedDate!.add(const Duration(days: 7 * 26 + 1))),
                          ' - ',
                          DateFormat('MMM d').format(_dueDate!),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow(String label, String startDate, String separator, String endDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        Text(
          startDate + separator + endDate,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}