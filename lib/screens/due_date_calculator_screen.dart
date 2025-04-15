import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';

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
      trimester = context.tr('firstTrimester');
    } else if (weeksPregnant < 27) {
      trimester = context.tr('secondTrimester');
    } else {
      trimester = context.tr('thirdTrimester');
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
    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

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
    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Adjust sizes based on screen size
    final titleFontSize = isSmallScreen ? 15.0 : 16.0;
    final headerFontSize = isSmallScreen ? 16.0 : 18.0;
    final dateFontSize = isSmallScreen ? 20.0 : 24.0;
    final infoRowLabelSize = isSmallScreen ? 13.0 : 14.0;
    final infoRowValueSize = isSmallScreen ? 14.0 : 16.0;
    final padding = isSmallScreen ? 12.0 : 16.0;
    final spacing = isSmallScreen ? 12.0 : 16.0;
    final cardSpacing = isSmallScreen ? 18.0 : 24.0;

    // Date formatter based on locale
    final dateFormatter = DateFormat.yMMMMd(context.loc.locale.languageCode);
    final shortDateFormatter = DateFormat.MMMd(context.loc.locale.languageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('dueDateCalculator'),
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: isSmallScreen ? 18.0 : 20.0,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
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
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('lastPeriodQuestion'),
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: spacing),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppTheme.primaryColor),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: padding,
                              vertical: isSmallScreen ? 10 : 12,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? context.tr('selectDate')
                                    : dateFormatter.format(_selectedDate!),
                                style: TextStyle(
                                  color: _selectedDate == null
                                      ? Colors.grey
                                      : AppTheme.textPrimaryColor,
                                  fontSize: isSmallScreen ? 14.0 : 15.0,
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
                      SizedBox(height: spacing),
                      if (_selectedDate != null)
                        ElevatedButton(
                          onPressed: _calculateDueDate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 10 : 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: Text(context.tr('calculateDueDate')),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: cardSpacing),
              if (_dueDate != null) ...[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          context.tr('yourDueDate'),
                          style: TextStyle(
                            fontSize: headerFontSize,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          dateFormatter.format(_dueDate!),
                          style: TextStyle(
                            fontSize: dateFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: cardSpacing),
                        _buildInfoRow(
                          context.tr('weeksPregnant'),
                          context.tr('weeksAndDays', {
                            'weeks': '$_weeksPregnant',
                            'days': '$_daysPregnant'
                          }),
                          infoRowLabelSize,
                          infoRowValueSize,
                        ),
                        SizedBox(height: spacing / 2),
                        _buildInfoRow(
                          context.tr('trimester'),
                          _trimester!,
                          infoRowLabelSize,
                          infoRowValueSize,
                        ),
                        SizedBox(height: spacing / 2),
                        _buildInfoRow(
                          context.tr('progress'),
                          '${((_weeksPregnant! * 7 + _daysPregnant!) / 280 * 100).toStringAsFixed(1)}%',
                          infoRowLabelSize,
                          infoRowValueSize,
                        ),
                        SizedBox(height: spacing),
                        LinearProgressIndicator(
                          value: (_weeksPregnant! * 7 + _daysPregnant!) / 280,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: cardSpacing),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('importantDates'),
                          style: TextStyle(
                            fontSize: headerFontSize,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(height: spacing),
                        _buildDateRow(
                          context.tr('firstTrimester'),
                          shortDateFormatter.format(_selectedDate!),
                          ' - ',
                          shortDateFormatter.format(_selectedDate!.add(const Duration(days: 7 * 13))),
                          infoRowLabelSize,
                          infoRowValueSize,
                        ),
                        SizedBox(height: spacing / 2),
                        _buildDateRow(
                          context.tr('secondTrimester'),
                          shortDateFormatter.format(_selectedDate!.add(const Duration(days: 7 * 13 + 1))),
                          ' - ',
                          shortDateFormatter.format(_selectedDate!.add(const Duration(days: 7 * 26))),
                          infoRowLabelSize,
                          infoRowValueSize,
                        ),
                        SizedBox(height: spacing / 2),
                        _buildDateRow(
                          context.tr('thirdTrimester'),
                          shortDateFormatter.format(_selectedDate!.add(const Duration(days: 7 * 26 + 1))),
                          ' - ',
                          shortDateFormatter.format(_dueDate!),
                          infoRowLabelSize,
                          infoRowValueSize,
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

  Widget _buildInfoRow(String label, String value, double labelSize, double valueSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: labelSize,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: valueSize,
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow(String label, String startDate, String separator, String endDate, double labelSize, double valueSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: labelSize,
          ),
        ),
        Text(
          startDate + separator + endDate,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: valueSize,
          ),
        ),
      ],
    );
  }
}