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

    // Save both values to user provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setDueDate(dueDate);
    userProvider.setLastPeriodDate(_selectedDate!);  // Save last period date too

    // Auto-scroll to results
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_resultsKey.currentContext != null) {
        Scrollable.ensureVisible(
          _resultsKey.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  final GlobalKey _resultsKey = GlobalKey();

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
      });
      // Automatically calculate when date is selected
      _calculateDueDate();
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
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedDate == null
                                  ? Colors.grey.shade400
                                  : AppTheme.primaryColor,
                              width: _selectedDate == null ? 1 : 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              border: InputBorder.none,
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
                                    fontWeight: _selectedDate == null
                                        ? FontWeight.normal
                                        : FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: _selectedDate == null
                                      ? Colors.grey
                                      : AppTheme.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: cardSpacing),

              if (_dueDate != null) ...[
                // Results section
                Card(
                  key: _resultsKey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_available,
                          color: AppTheme.primaryColor,
                          size: isSmallScreen ? 36 : 48,
                        ),
                        SizedBox(height: spacing),
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
                        Divider(color: AppTheme.dividerColor),
                        SizedBox(height: spacing),
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
                          minHeight: 8,
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
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: AppTheme.primaryColor,
                              size: isSmallScreen ? 20 : 24,
                            ),
                            SizedBox(width: spacing / 2),
                            Text(
                              context.tr('importantDates'),
                              style: TextStyle(
                                fontSize: headerFontSize,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
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
              ] else if (_selectedDate == null) ...[
                // Empty state
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(padding * 2),
                      child: Column(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: isSmallScreen ? 48 : 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: spacing),
                          Text(
                            context.tr('pleaseSelectDate'),
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14.0 : 16.0,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,  // Gibt dem Label mehr Platz
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: labelSize,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(width: 8), // Kleiner Abstand
          Expanded(
            flex: 3,  // Gibt dem Wert mehr Platz
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: valueSize,
                color: AppTheme.textPrimaryColor,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRow(String label, String startDate, String separator, String endDate, double labelSize, double valueSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: labelSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            startDate + separator + endDate,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: valueSize,
              color: AppTheme.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}