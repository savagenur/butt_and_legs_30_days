import 'package:butt_and_legs_3_min/constants.dart';
import 'package:butt_and_legs_3_min/features/data/models/day/day_model.dart';
import 'package:butt_and_legs_3_min/features/domain/entities/exercise/exercise_entity.dart';
import 'package:butt_and_legs_3_min/features/presentation/pages/exercise/exercise_page.dart';
import 'package:butt_and_legs_3_min/features/presentation/widgets/my_button_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/models/exercise/exercise_model.dart';

class HomePage extends StatefulWidget {
  final int dayIndex;
  const HomePage({super.key, required this.dayIndex});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Box<DayModel> days = Hive.box<DayModel>("daysBox");
  late int currentDay;
  bool visionDouble = true;
  CarouselController scrollController = CarouselController();

  @override
  void initState() {
    currentDay = widget.dayIndex;
    setState(() {});
    super.initState();
  }

  dayListenController() {
    days.listenable().addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            buildCarouselSlider(),
            sizeVer(30),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Exercises",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Target",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  sizeVer(10),
                  AnimatedOpacity(
                    opacity: visionDouble ? 1 : 0,
                    duration: Duration(milliseconds: 150),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: days.getAt(currentDay)!.exercises!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var exercises = days.getAt(currentDay)!.exercises!;
                          return Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${exercises[index].name}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${exercises[index].reps} reps",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: MyButtonWidget(
          text: "Start",
          onTap: () {
            Hive.box<int>("selectedDayBox").putAt(0, currentDay);
            print(Hive.box<int>("selectedDayBox").values);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExercisePage(
                    dayModel: days.getAt(currentDay)!,
                  ),
                ));
          },
          backgroundColor: primaryColor,
          paddingAll: 15,
        ),
      ),
    );
  }

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      carouselController: scrollController,
      items: List.generate(days.length, (index) {
        int day = days.getAt(index)!.day!;
        return Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  color:days.getAt(index)!.isDayDone!?Colors.green: orangeColor, borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Day $day",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
        );
      }),
      options: CarouselOptions(
          initialPage: currentDay,
          height: 150,
          onScrolled: (value) {
            setState(() {
              currentDay = value!.round();
            });
          },
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: false),
    );
  }
}
