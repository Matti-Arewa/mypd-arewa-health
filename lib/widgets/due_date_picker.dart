import 'package:flutter/material.dart';
import '../services/localization_service.dart';
import 'package:intl/intl.dart';

class DueDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;

  const DueDatePicker({
    Key? key,
    required this.onDateSelected,
    this.initialDate,
  }) : super(key: key);

  @override
  State<DueDatePicker> createState() => _DueDatePickerState();
}

class _DueDatePickerState extends State<DueDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // Set default selected date to 9 months from now
    _selectedDate = widget.initialDate ?? DateTime.now().add(const Duration(days: 280));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 300)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).textTheme.bodyLarge!.color!,
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
      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Adjust sizes based on screen size
    final buttonFontSize = isSmallScreen ? 14.0 : 16.0;
    final dateFontSize = isSmallScreen ? 15.0 : 17.0;
    final verticalPadding = isSmallScreen ? 10.0 : 12.0;
    final horizontalPadding = isSmallScreen ? 12.0 : 16.0;
    final spacing = isSmallScreen ? 12.0 : 16.0;

    // Format date according to locale
    final dateFormat = DateFormat.yMd(context.loc.locale.languageCode);
    final formattedDate = dateFormat.format(_selectedDate);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: dateFontSize,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                  size: isSmallScreen ? 20 : 24,
                ),
                onPressed: () => _selectDate(context),
                tooltip: context.tr('selectDate'),
              ),
            ],
          ),
        ),
        SizedBox(height: spacing),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding * 1.5,
            ),
          ),
          child: Text(
            context.tr('changeDate'),
            style: TextStyle(fontSize: buttonFontSize),
          ),
        ),
      ],
    );
  }
}