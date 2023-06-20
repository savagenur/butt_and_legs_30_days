import 'package:butt_and_legs_3_min/constants.dart';
import 'package:butt_and_legs_3_min/features/presentation/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class RestPage extends StatefulWidget {
  const RestPage({super.key});

  @override
  State<RestPage> createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> {
  int currentValue = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
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
                    "30",
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
                          selectedTextStyle: TextStyle(color: whiteColor,fontSize: 24),
                          minValue: 0,
                          maxValue: 100,
                          value: currentValue,
                          onChanged: (value) {
                            setState(() {
                              currentValue = value;
                            });
                          },
                        ),
                        sizeHor(10),
                        Expanded(
                          child: Column(
                            children: [
                              MyButtonWidget(
                                text: "Save",
                                onTap: () {},
                                paddingAll: 15,
                                backgroundColor: primaryColor,
                              ),
                              sizeVer(10),
                              MyButtonWidget(
                                text: "Next",
                                onTap: () {},
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
                          text: "Next exercise: ",
                          style: TextStyle(color: primaryColor, fontSize: 16),
                          children: [
                            TextSpan(
                                text: "Calf Raise",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
