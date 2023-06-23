import 'package:butt_and_legs_3_min/features/domain/entities/exercise/exercise_entity.dart';
import 'package:equatable/equatable.dart';


class DayEntity extends Equatable {
  final int? day;
  final List<ExerciseEntity>? exercises;
  final bool? isDayDone;

  const DayEntity({
    this.day,
    this.exercises,
    this.isDayDone,
  });

  @override
  List<Object?> get props => [
        day,
        exercises,
        isDayDone,
      ];
}
