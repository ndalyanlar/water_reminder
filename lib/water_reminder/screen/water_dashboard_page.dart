import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extension/extensions.dart';

import '../../util/style/utils.dart';
import '../provider/water_reminder_bloc.dart';
import '../utility/my_painter.dart';
import '../widget/daily_target_water_tile.dart';
import '../widget/reminder_period_tile.dart';
import '../widget/time_textfield.dart';
import '../widget/water_buttons.dart';

class WaterReminderPage extends ConsumerStatefulWidget {
  const WaterReminderPage({Key? key}) : super(key: key);

  @override
  WaterReminderPageState createState() => WaterReminderPageState();
}

class WaterReminderPageState extends WaterReminderBloc {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.instance.darkSecondaryColor,
        elevation: 0,
        title: const Text('Water Reminder'),
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: MyPainter(
              firstAnimation?.value ?? 0,
              secondAnimation?.value ?? 0,
              thirdAnimation?.value ?? 0,
              fourthAnimation?.value ?? 0,
            ),
            child: SizedBox(
              height: size.height,
              width: size.width,
            ),
          ),
          Center(
            child: FittedBox(
              child: Padding(
                padding: const CustomPadding.symetric(),
                child: Text(
                    '${(model.value / targetTextController.text.toInt() * 100).toStringAsFixed(1)} %',
                    style: AppTheme.title,
                    textScaleFactor: 7),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.instance.darkSecondaryColor,
                    AppColor.instance.backgroundColor.withOpacity(.5),
                    AppColor.instance.backgroundColor.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const CustomPadding.symetric(vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TimeTextField(
                            controller: beginHourTextController,
                            onTap: () {
                              showDialogTime(
                                context,
                                model.beginTime,
                                beginTimeChange,
                              );
                            },
                            title: ("Start hour"),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: TimeTextField(
                            controller: endHourTextController,
                            onTap: () {
                              showDialogTime(
                                context,
                                model.endTime,
                                endTimeChange,
                              );
                            },
                            title: ("End Hour"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: CustomPadding.maxPaddingAll,
                    child: DailyTargetWaterTile(
                      title: ("Daily target water"),
                      mlController: mlController,
                      targetController: targetTextController,
                      onChange: targetChange,
                    ),
                  ),
                  Padding(
                    padding: CustomPadding.maxPaddingHorizontal,
                    child: ReminderPeriodTile(
                      title: ("Reminder period"),
                      model: model,
                      hours: hours,
                      onChanged: changePeriod,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const CustomPadding.symetric(vertical: 40),
                      child: WaterButtons(
                        increaseAmount: increaseAmount,
                        decreaseAmount: decreaseAmount,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
