import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../util/style/utils.dart';
import '../model/water_reminder_model.dart';

class ReminderPeriodTile extends ConsumerWidget {
  const ReminderPeriodTile({
    Key? key,
    required this.title,
    required this.model,
    required this.hours,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final WaterReminderModel model;
  final List<String> hours;
  final void Function(String?) onChanged;
  @override
  Widget build(BuildContext context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              AppTheme.title.copyWith(color: AppColor.instance.backgroundColor),
        ),
        DropdownButton<String>(
          dropdownColor: AppColor.instance.lightPrimaryColor,
          style: AppTheme.title,
          value: model.selectedHour,
          items: List.generate(hours.length, (index) {
            return DropdownMenuItem<String>(
              value: hours[index],
              child: Text(
                hours[index],
              ),
            );
          }),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
