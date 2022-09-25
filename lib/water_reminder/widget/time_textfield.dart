import 'package:flutter/material.dart';

import '../../util/style/utils.dart';

class TimeTextField extends StatelessWidget {
  const TimeTextField({
    Key? key,
    required this.controller,
    required this.onTap,
    required this.title,
  }) : super(key: key);
  final TextEditingController controller;
  final void Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      style: AppTheme.title.copyWith(
        color: AppColor.instance.backgroundColor,
      ),
      decoration: InputDecoration(
        labelStyle: AppTheme.title.copyWith(
          color: AppColor.instance.backgroundColor,
        ),
        labelText: title,
      ),
      controller: controller,
      onTap: onTap,
    );
  }
}
