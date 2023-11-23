import 'package:flutter/material.dart';

typedef TimeSelectedCallback = void Function(int minute);

class TimerOption extends StatelessWidget {
  final int minute;
  final TimeSelectedCallback onTimeSelected;

  const TimerOption({
    super.key,
    required this.minute,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTimeSelected(minute);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColorLight,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          '$minute',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
