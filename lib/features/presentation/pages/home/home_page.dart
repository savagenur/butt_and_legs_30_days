import 'package:butt_and_legs_3_min/constants.dart';
import 'package:butt_and_legs_3_min/features/presentation/widgets/my_button_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: orangeColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Day 1",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: orangeColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Day 2",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: orangeColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Day 3",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
              options: CarouselOptions(
                  height: 150,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false),
            ),
            sizeVer(30),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Exercises",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          sizeVer(10),
                          ...List.generate(
                              10,
                              (index) => Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text(
                                    "Leg Raise Plank Right",
                                    style: TextStyle(fontSize: 16),
                                  )))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Target",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          sizeVer(10),
                          ...List.generate(
                              10,
                              (index) => Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text(
                                    "10 Reps",
                                    style: TextStyle(fontSize: 16),
                                  )))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: MyButtonWidget(text: "Start",onTap: () {
                        
                      },backgroundColor: primaryColor,paddingAll: 15,),
      ),
    );
  }
}
