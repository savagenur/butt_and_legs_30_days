import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:butt_and_legs_3_min/constants.dart';
import 'package:butt_and_legs_3_min/features/data/models/day/day_model.dart';
import 'package:butt_and_legs_3_min/features/data/models/exercise/exercise_model.dart';
import 'package:butt_and_legs_3_min/features/domain/entities/day/day_entity.dart';
import 'package:butt_and_legs_3_min/features/presentation/pages/rest/rest_page.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ExercisePage extends StatefulWidget {
  final DayModel dayModel;
  const ExercisePage({super.key, required this.dayModel});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  PageController pageController = PageController();
  var pageIndex = 0;
  var initSeconds = 35000;
  bool isPlaying = false;
  bool isPaused = false;
  bool isLastPage = false;
  bool isStarting = false;

  // Timer section

  late StopWatchTimer _stopWatchTimer;
  @override
  void initState() {
    initTimer();
    super.initState();
  }

  initTimer() {
    _stopWatchTimer = StopWatchTimer(
      presetMillisecond: initSeconds,
      mode: StopWatchMode.countDown,
      onStopped: () {
        setState(() {
          isPaused = true;
        });
      },
      onChangeRawSecond: (p0) {
        if (p0 == 0) {
          int nextPage = getNextPageIndex(pageIndex);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestPage(
                    currentExerciseIndex: pageIndex,
                    dayIndex: widget.dayModel.day! - 1,
                    isLastExercise: isLastPage,
                    currentExercise: widget.dayModel.exercises![pageIndex],
                    nextExercise: widget.dayModel.exercises![nextPage]),
              ));
          _stopWatchTimer.onResetTimer();
          pageController.jumpToPage(nextPage);
        }
      },
      onEnded: () {
        setState(() {
          isPlaying = false;
          isPaused = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  int getNextPageIndex(int currentPageIndex) {
    int nextPageIndex = currentPageIndex + 1;
    if (nextPageIndex >= 0 &&
        nextPageIndex < widget.dayModel.exercises!.length) {
      isLastPage = false;

      return nextPageIndex;
    } else {
      isLastPage = true;

      return currentPageIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _stopWatchTimer.secondTime,
        initialData: initSeconds,
        builder: (context, snapshot) {
          final value = snapshot.data ?? initSeconds;

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              title: isPlaying
                  ? Text(
                      "$value",
                      style: TextStyle(
                        fontSize: 33,
                        color: orangeColor,
                      ),
                    )
                  : isPaused
                      ? AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration(milliseconds: 100),
                          animatedTexts: [
                            ScaleAnimatedText(
                              "$value",
                              textStyle: TextStyle(
                                fontSize: 30,
                                color: orangeColor,
                              ),
                              scalingFactor: .8,
                              textAlign: TextAlign.center,
                              duration: Duration(milliseconds: 2000),
                            ),
                          ],
                        )
                      : Container(),
              centerTitle: true,
              elevation: 0,
              backgroundColor: backgroundColor,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20, top: 20),
                  child: Text(
                    "Day ${widget.dayModel.day}",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
            body: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                pageIndex = value;
                _stopWatchTimer.onResetTimer();
              },
              itemCount: widget.dayModel.exercises!.length,
              itemBuilder: (context, index) {
                var exercise = widget.dayModel.exercises![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          exercise.imagePath!,
                          height: 350,
                        ),
                        Positioned(
                            child: isStarting
                                ? AnimatedTextKit(
                                    pause: Duration(milliseconds: 500),
                                    isRepeatingAnimation: false,
                                    animatedTexts: [
                                        FadeAnimatedText("READY",
                                            textStyle: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                            duration:
                                                Duration(milliseconds: 700)),
                                        FadeAnimatedText("SET",
                                            textStyle: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                            duration:
                                                Duration(milliseconds: 700)),
                                        FadeAnimatedText("GO!",
                                            textStyle: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                            duration:
                                                Duration(milliseconds: 700)),
                                      ])
                                : Container())
                      ],
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          color: orangeColor,
                          padding: EdgeInsets.all(30),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    pageController.previousPage(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Icon(Icons.arrow_back_ios)),
                              Spacer(),
                              Expanded(
                                  flex: 10,
                                  child: Text(
                                    exercise.name!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 18),
                                  )),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    pageController.nextPage(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -25,
                          child: InkWell(
                            onTap: () async {
                              final player = AudioPlayer();

                              if (!isPlaying) {
                                setState(() {
                                  isStarting = true;
                                });
                                await Future.delayed(
                                    Duration(milliseconds: 2800));
                                await player.play(AssetSource(
                                    "mixkit-correct-answer-tone-2870.wav"));
                                _stopWatchTimer.onStartTimer();

                                setState(() {});
                              } else {
                                _stopWatchTimer.onStopTimer();
                              }

                              setState(() {
                                isPlaying = !isPlaying;
                                isStarting = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  color: !isPlaying ? primaryColor : Colors.red,
                                  shape: BoxShape.circle),
                              child: !isPlaying
                                  ? Icon(
                                      Icons.play_arrow,
                                      color: whiteColor,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.pause,
                                      color: whiteColor,
                                      size: 50,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizeVer(40),
                    Text(
                      "Target: ${exercise.reps} reps",
                      style: TextStyle(fontSize: 16),
                    ),
                    sizeVer(15),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          exercise.description!,
                          style: TextStyle(fontSize: 14, color: secondaryColor),
                        )),
                    sizeVer(20),
                  ],
                );
              },
            ),
          );
        });
  }
}
