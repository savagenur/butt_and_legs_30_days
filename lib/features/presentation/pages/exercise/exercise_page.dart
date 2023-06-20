import 'package:butt_and_legs_3_min/constants.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Text(
              "Day 1",
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/fire-hydrant-exercise-woman-workout.avif",
            height: 350,
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
                    Icon(Icons.arrow_back_ios),
                    Spacer(),
                    Expanded(
                        flex: 10,
                        child: Text(
                          "Fire hydrand Right",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: primaryColor, fontSize: 18),
                        )),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              Positioned(
                bottom: -25,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.play_arrow,
                    color: whiteColor,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
          sizeVer(40),
          Text(
            "Target: 16 reps",
            style: TextStyle(fontSize: 16),
          ),
          sizeVer(15),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Tget: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 repsTarget: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 repsTarget: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 repsTarget: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps Target: 16 reps ",
                style: TextStyle(fontSize: 14,color: secondaryColor),
              )),
          sizeVer(20),
        ],
      ),
    );
  }
}
