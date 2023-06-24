import 'package:butt_and_legs_3_min/constants.dart';
import 'package:butt_and_legs_3_min/features/presentation/pages/home/home_page.dart';
import 'package:butt_and_legs_3_min/features/presentation/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

class WellDonePage extends StatelessWidget {
  const WellDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            sizeVer(20),
            Lottie.asset("assets/73862-confetti.json"),
            Lottie.asset("assets/72582-congratulations.json"),
            MyButtonWidget(
                text: "Go Home",
                paddingAll: 20  ,
                backgroundColor: primaryColor,
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                          dayIndex: Hive.box<int>("selectedDayBox").values.first),
                    ),
                    (route) => false))
          ],
        ),
      ),
    );
  }
}
