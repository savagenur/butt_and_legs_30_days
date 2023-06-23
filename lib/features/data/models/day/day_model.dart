import 'package:butt_and_legs_3_min/features/data/models/exercise/exercise_model.dart';
import 'package:butt_and_legs_3_min/features/domain/entities/exercise/exercise_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/entities/day/day_entity.dart';
part 'day_model.g.dart';
@HiveType(typeId: 0)
class DayModel extends DayEntity with HiveObjectMixin {
  @HiveField(0)
  final int? day;
  @HiveField(1)
  final List<ExerciseModel>? exercises;
  @HiveField(2)
  final bool? isDayDone;

  DayModel({
    this.day,
    this.exercises,
    this.isDayDone,
  });

  DayModel copyWith({
    int? day,
    List<ExerciseModel>? exercises,
    bool? isDayDone,
  }) {
    return DayModel(
      day: day ?? this.day,
      exercises: exercises ?? this.exercises,
      isDayDone: isDayDone ?? this.isDayDone,
    );
  }
}
