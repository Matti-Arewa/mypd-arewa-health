import 'package:flutter/material.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => _selectDate(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: const Text('Change Date'),
        ),
      ],
    );
  }
}