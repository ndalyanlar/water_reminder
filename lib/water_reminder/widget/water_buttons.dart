import 'package:flutter/material.dart';

import 'water_button.dart';

class WaterButtons extends StatelessWidget {
  const WaterButtons({
    Key? key,
    required this.increaseAmount,
    required this.decreaseAmount,
  }) : super(key: key);

  final void Function(int) increaseAmount;
  final void Function(int) decreaseAmount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WaterButton(
            increaseAmount: () => increaseAmount(200),
            decreaseAmount: () => decreaseAmount(200),
            text: "200"),
        WaterButton(
            increaseAmount: () => increaseAmount(500),
            decreaseAmount: () => decreaseAmount(500),
            text: "500"),
        WaterButton(
            increaseAmount: () => increaseAmount(1500),
            decreaseAmount: () => decreaseAmount(1500),
            text: "1500"),
      ],
    );
  }
}
