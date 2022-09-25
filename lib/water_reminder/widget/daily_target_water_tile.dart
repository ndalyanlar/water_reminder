import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../extension/extensions.dart';
import '../../util/style/utils.dart';

class DailyTargetWaterTile extends StatelessWidget {
  const DailyTargetWaterTile({
    Key? key,
    required this.title,
    required this.mlController,
    required this.targetController,
    required this.onChange,
  }) : super(key: key);

  final String title;
  final void Function(String) onChange;
  final TextEditingController mlController;
  final TextEditingController targetController;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTheme.title.copyWith(
              color: AppColor.instance.backgroundColor,
            ),
          ),
        ),
        TextField(
          textAlign: TextAlign.end,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: onChange,
          controller: mlController,
          style:
              AppTheme.title.copyWith(color: AppColor.instance.backgroundColor),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: CustomPadding.minPaddingAll,
            constraints: BoxConstraints(maxWidth: context.getDynamicWidth(.2)),
            hintText: targetController.text,
            hintStyle:
                AppTheme.body1.copyWith(color: AppColor.instance.textColorDark),
          ),
        ),
        Text("ml",
            style:
                AppTheme.body1.copyWith(color: AppColor.instance.textColorDark))
      ],
    );
  }
}
