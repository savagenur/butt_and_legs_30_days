part of 'day_bloc.dart';

abstract class DayEvent extends Equatable {
  const DayEvent();

  @override
  List<Object> get props => [];
}

class InitFirstDataDayEvent extends DayEvent {}

class UpdateExerciseDayEvent extends DayEvent {
  final int dayIndex;
  final int exerciseIndex;
  final int reps;
  const UpdateExerciseDayEvent({
    required this.dayIndex,
    required this.reps,
    required this.exerciseIndex,
  });
}

class DeleteExerciseDayEvent extends DayEvent {
  final int dayIndex;
  final int exerciseIndex;
  const DeleteExerciseDayEvent({
    required this.dayIndex,
    required this.exerciseIndex,
  });
}
