import 'dart:io';

import 'package:butt_and_legs_3_min/features/presentation/pages/home/home_page.dart';
import 'package:butt_and_legs_3_min/features/presentation/pages/welcome/welcome_page.dart';
import 'package:butt_and_legs_3_min/init_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/data/models/day/day_model.dart';
import 'features/data/models/exercise/exercise_model.dart';
import 'features/presentation/bloc/day/bloc/day_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseModelAdapter());
  Hive.registerAdapter(DayModelAdapter());

  await Hive.openBox<DayModel>("daysBox");
  await Hive.openBox<int>("selectedDayBox");
  var dayBox = Hive.box<DayModel>("daysBox");
  var selectedDayBox = Hive.box<int>("selectedDayBox");
  if (dayBox.isEmpty) {
    dayBox.addAll(kDaysList);
    selectedDayBox.add(0);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: "Rubik"),
          bodySmall: TextStyle(fontFamily: "Rubik"),
          bodyMedium: TextStyle(fontFamily: "Rubik"),
        ),
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}
