import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../../extension/extensions.dart';
import '../../main.dart';
import '../../util/style/utils.dart';
import '../model/water_reminder_model.dart';
import '../screen/water_dashboard_page.dart';

abstract class WaterReminderBloc extends ConsumerState<WaterReminderPage>
    with TickerProviderStateMixin {
  final String _hiveWaterReminderKey = "water_reminder";

  Future<WaterReminderModel?> hiveInit() async {
    box = await Hive.openBox(_hiveWaterReminderKey);

    box.get(_hiveWaterReminderKey) != null
        ? model = box.get(_hiveWaterReminderKey)
        : null;

    targetTextController.text = model.target;
    beginHourTextController.text = model.beginTime.toString().substring(11, 16);
    endHourTextController.text = model.endTime.toString().substring(11, 16);
    return model;
  }

  late WaterReminderModel model;
  late Box box;
  late List<String> hours;

  final TextEditingController targetTextController = TextEditingController();
  final TextEditingController beginHourTextController = TextEditingController();
  final TextEditingController endHourTextController = TextEditingController();
  final TextEditingController mlController = TextEditingController();

  AnimationController? firstController;
  Animation<double>? firstAnimation;

  AnimationController? secondController;
  Animation<double>? secondAnimation;

  AnimationController? thirdController;
  Animation<double>? thirdAnimation;

  AnimationController? fourthController;
  Animation<double>? fourthAnimation;

  Timer? time1;
  Timer? time2;
  Timer? time3;

  @override
  void initState() {
    hours = [
      "00:30",
      "01:00",
      "01:30",
      "02:00",
      "02:30",
      "03:00",
      "03:30",
      "04:00",
      "04:30",
      "05:00",
      "05:30",
      "06:00",
    ];

    if (!Hive.isAdapterRegistered(WaterReminderModelAdapter().typeId)) {
      Hive.registerAdapter(WaterReminderModelAdapter());
    }

    model = WaterReminderModel(
      value: 0,
      target: '1500',
      beginTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 12),
      endTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 18),
      selectedHour: hours.first,
    );

    hiveInit();

    loadFirstController();
    loadSecondController();
    loadThirdController();
    loadFourthController();
    loadTimer();

    super.initState();
  }

  void changePeriod(String? hour) async {
    setState(() {
      model = model.copyWith(selectedHour: hour);
    });
    await box.put(_hiveWaterReminderKey, model);
  }

  void increaseAmount(int ml) async {
    if (model.value > model.target.toInt()) {
      return await showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: AppTheme.mainBorderRadius),
            child: SizedBox(
              height: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 2,
                    child: FittedBox(child: Icon(Icons.task_alt_rounded)),
                  ),
                  const Expanded(
                    child: Text(
                      "You have reached your daily goal",
                      style: AppTheme.title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: CustomPadding.minPaddingAll,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK")),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    setState(() {
      model = model.copyWith(value: model.value + ml);
    });
    await box.put(_hiveWaterReminderKey, model);
  }

  void decreaseAmount(int ml) async {
    if ((model.value - ml.toDouble()) <= 0) {
      model.value = 0;
      setState(() {});
      return;
    }

    setState(() {
      model = model.copyWith(value: model.value - ml.toDouble());
    });
    await box.put(_hiveWaterReminderKey, model);
  }

  void targetChange(String value) async {
    setState(() {
      model = model.copyWith(target: value != "" ? value : "1500");
      targetTextController.text = value;
    });

    await box.put(_hiveWaterReminderKey, model);
  }

  void endTimeChange(DateTime endTime) async {
    endHourTextController.text =
        "${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}";
    model = model.copyWith(endTime: endTime);
    await box.put(_hiveWaterReminderKey, model.copyWith(endTime: endTime));
  }

  void beginTimeChange(beginTime) async {
    beginHourTextController.text =
        "${beginTime.hour.toString().padLeft(2, '0')}:${beginTime.minute.toString().padLeft(2, '0')}";

    await box.put(_hiveWaterReminderKey, model.copyWith(beginTime: beginTime));
  }

  void loadFirstController() {
    firstController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 1.8, end: 2.1).animate(
        CurvedAnimation(parent: firstController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController?.reverse().orCancel;
        } else if (status == AnimationStatus.dismissed) {
          firstController?.forward().orCancel;
        }
      });
  }

  void loadSecondController() {
    secondController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: secondController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController?.reverse().orCancel;
        } else if (status == AnimationStatus.dismissed) {
          secondController?.forward().orCancel;
        }
      });
  }

  void loadThirdController() {
    thirdController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController?.reverse().orCancel;
        } else if (status == AnimationStatus.dismissed) {
          thirdController?.forward().orCancel;
        }
      });
  }

  void loadFourthController() {
    fourthController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController!, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController?.reverse().orCancel;
        } else if (status == AnimationStatus.dismissed) {
          fourthController?.forward().orCancel;
        }
      });
  }

  void loadTimer() {
    time1 = Timer(const Duration(seconds: 2), () {
      firstController?.forward().orCancel;
    });

    time2 = Timer(const Duration(milliseconds: 1600), () {
      secondController?.forward().orCancel;
    });

    time3 = Timer(const Duration(milliseconds: 800), () {
      thirdController?.forward().orCancel;
    });
  }

  Future<dynamic> showDialogTime(BuildContext context, DateTime dt,
      void Function(DateTime dt) onDateTimeChange) async {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Center(
            child: Padding(
              padding: const CustomPadding.symetric(vertical: 0),
              child: Container(
                height: context.getDynamicHeight(.4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CupertinoDatePicker(
                        use24hFormat: true,
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: onDateTimeChange,
                        initialDateTime: DateTime(DateTime.now().year).add(
                          Duration(
                            hours: dt.hour,
                            minutes: dt.minute,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Confirm", style: AppTheme.title)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    firstController?.dispose();
    secondController?.dispose();
    thirdController?.dispose();
    fourthController?.dispose();

    super.dispose();
  }
}
