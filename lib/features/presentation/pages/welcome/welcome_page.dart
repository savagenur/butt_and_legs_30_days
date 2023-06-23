import 'package:butt_and_legs_3_min/constants.dart';
import 'package:butt_and_legs_3_min/features/presentation/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../home/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedDayBox = Hive.box<int>("selectedDayBox");
    int selectedDay = selectedDayBox.values.first;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        actions: [
          GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "30 DAYS\n",
                style: TextStyle(
                  fontSize: 35,
                ),
                children: [
                  TextSpan(
                    text: "BUTT AND LEGS",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/welcome.png",
              width: MediaQuery.of(context).size.width * .8,
            ),
            const Spacer(),
            MyButtonWidget(
              text: "Start",
              backgroundColor: primaryColor,
              paddingAll: 15,
              fontSize: 28,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        dayIndex: selectedDay,
                      ),
                    ));
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
