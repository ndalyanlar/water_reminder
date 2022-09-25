import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extension/padding_extension.dart';
import '../../init/icon/custom_icons.dart';

import '../../util/style/utils.dart';

class WaterButton extends StatefulWidget {
  const WaterButton({
    Key? key,
    required this.increaseAmount,
    required this.decreaseAmount,
    required this.text,
  }) : super(key: key);

  final void Function() increaseAmount;
  final void Function() decreaseAmount;
  final String text;

  @override
  State<WaterButton> createState() => _WaterButtonState();
}

class _WaterButtonState extends State<WaterButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => widget.increaseAmount(),
            icon: Icon(
              Icons.add,
              color: AppColor.instance.lightPrimaryColor,
            ),
          ),
          Row(
            children: [
              Text(
                widget.text,
                style: AppTheme.title.copyWith(
                  color: AppColor.instance.lightPrimaryColor,
                ),
              ),
              Padding(
                padding: CustomPadding.minPaddingHorizontal,
                child: Icon(
                  Icons.water_drop,
                  color: AppColor.instance.lightPrimaryColor,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => widget.decreaseAmount(),
            icon: Icon(
              Icons.remove,
              color: AppColor.instance.lightPrimaryColor,
            ),
          ),
        ],
      );
    });
  }
}
