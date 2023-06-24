import 'package:butt_and_legs_3_min/constants.dart';
import 'package:butt_and_legs_3_min/features/data/models/day/day_model.dart';
import 'package:butt_and_legs_3_min/features/data/models/exercise/exercise_model.dart';
import 'package:butt_and_legs_3_min/features/domain/entities/exercise/exercise_entity.dart';
import 'package:butt_and_legs_3_min/features/presentation/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../home/home_page.dart';

class RestPage extends StatefulWidget {
  final ExerciseEntity currentExercise;
  final ExerciseEntity nextExercise;
  final int dayIndex;
  final int currentExerciseIndex;
  final bool isLastExercise;

  const RestPage(
      {super.key,
      required this.currentExercise,
      required this.nextExercise,
      required this.isLastExercise,
      required this.dayIndex,
      required this.currentExerciseIndex});

  @override
  State<RestPage> createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> {
  late int currentValue;
  int restTime = 16000;
  bool isSaved = false;
  late StopWatchTimer _stopWatchTimer;
  var days = Hive.box<DayModel>("daysBox");
  @override
  void initState() {
    if (widget.isLastExercise) {
      currentValue = days
          .getAt(widget.dayIndex)!
          .exercises![widget.currentExerciseIndex]
          .reps!;
    } else {
      currentValue = days
          .getAt(widget.dayIndex)!
          .exercises![widget.currentExerciseIndex - 1]
          .reps!;
    }
    initTimer();
    _stopWatchTimer.onStartTimer();
    super.initState();
  }

  initTimer() {
    _stopWatchTimer = StopWatchTimer(
      presetMillisecond: restTime,
      mode: StopWatchMode.countDown,
      onEnded: () {},
      onChange: (p0) {},
      onStopped: () {},
      onChangeRawSecond: (p0) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    int selectedDay = widget.dayIndex;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: StreamBuilder<int>(
          stream: _stopWatchTimer.secondTime,
          initialData: restTime,
          builder: (context, snapshot) {
            var value = snapshot.data;
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      20,
                    ),
                    child: Text(
                      "REST",
                      style: TextStyle(
                        fontSize: 40,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  sizeVer(10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * .5,
                        height: MediaQuery.of(context).size.width * .5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: Text(
                          "$value",
                          style: TextStyle(color: whiteColor, fontSize: 50),
                        ),
                      ),
                      Positioned(
                        top: 35,
                        child: Text(
                          "Time remaining:",
                          style: TextStyle(color: whiteColor, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  sizeVer(30),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      color: orangeColor,
                      child: Column(
                        children: [
                          Text(
                            "Enter how many reps completed:",
                            style: TextStyle(color: primaryColor, fontSize: 16),
                          ),
                          sizeVer(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NumberPicker(
                                selectedTextStyle:
                                    TextStyle(color: whiteColor, fontSize: 24),
                                minValue: 0,
                                maxValue: 100,
                                value: currentValue,
                                onChanged: (value) {
                                  setState(() {
                                    isSaved
                                        ? currentValue = currentValue
                                        : currentValue = value;
                                  });
                                },
                              ),
                              sizeHor(10),
                              Expanded(
                                child: Column(
                                  children: [
                                    MyButtonWidget(
                                      text: "Save",
                                      onTap: isSaved
                                          ? null
                                          : () {
                                              if (widget.isLastExercise) {
                                                var exercise = days
                                                    .getAt(widget.dayIndex)!
                                                    .exercises![widget
                                                        .currentExerciseIndex]
                                                    .copyWith(
                                                        reps: currentValue);
                                                days.putAt(
                                                    widget.dayIndex,
                                                    days
                                                        .getAt(widget.dayIndex)!
                                                        .copyWith(
                                                            exercises: days
                                                                .getAt(widget
                                                                    .dayIndex)!
                                                                .exercises!
                                                              ..removeAt(widget
                                                                  .currentExerciseIndex)
                                                              ..insert(
                                                                  widget
                                                                      .currentExerciseIndex,
                                                                  exercise)));
                                              } else {
                                                var exercise = days
                                                    .getAt(widget.dayIndex)!
                                                    .exercises![widget
                                                            .currentExerciseIndex -
                                                        1]
                                                    .copyWith(
                                                        reps: currentValue);
                                                days.putAt(
                                                    widget.dayIndex,
                                                    days
                                                        .getAt(widget.dayIndex)!
                                                        .copyWith(
                                                            exercises: days
                                                                .getAt(widget
                                                                    .dayIndex)!
                                                                .exercises!
                                                              ..removeAt(widget
                                                                      .currentExerciseIndex -
                                                                  1)
                                                              ..insert(
                                                                  widget.currentExerciseIndex -
                                                                      1,
                                                                  exercise)));
                                              }
                                              

                                              
                                              setState(() {
                                                isSaved = true;
                                              });
                                            },
                                      paddingAll: 15,
                                      backgroundColor: primaryColor,
                                    ),
                                    sizeVer(10),
                                    MyButtonWidget(
                                      text: widget.isLastExercise
                                          ? "Done"
                                          : "Next",
                                      onTap: () {
                                        widget.isLastExercise
                                            ? Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(
                                                    dayIndex: selectedDay,
                                                  ),
                                                ),
                                                (route) => false)
                                            : Navigator.pop(context);
                                        isSaved = false;
                                      },
                                      paddingAll: 15,
                                      backgroundColor: primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          sizeVer(20),
                          Text.rich(
                            TextSpan(
                                text: widget.isLastExercise
                                    ? "Current exercise: "
                                    : "Next exercise: ",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 16),
                                children: [
                                  TextSpan(
                                      text: widget.nextExercise.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
