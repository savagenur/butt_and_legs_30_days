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
  var dayBox = Hive.box<DayModel>("daysBox");
  if (dayBox.isEmpty) {
    dayBox.addAll(kDaysList);
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
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}
