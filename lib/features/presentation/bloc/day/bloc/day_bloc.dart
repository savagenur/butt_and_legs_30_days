import 'package:bloc/bloc.dart';
import 'package:butt_and_legs_3_min/init_data.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../data/models/day/day_model.dart';
import '../../../../data/models/exercise/exercise_model.dart';

part 'day_event.dart';
part 'day_state.dart';

class DayBloc extends Bloc<DayEvent, DayState> {
  DayBloc() : super(DayInitial()) {
    on<InitFirstDataDayEvent>(_onInitFirstDataDayEvent);
    on<UpdateExerciseDayEvent>(_onUpdateExerciseDayEvent);
    on<DeleteExerciseDayEvent>(_onDeleteExerciseDayEvent);
  }
  void _onInitFirstDataDayEvent(
      InitFirstDataDayEvent event, Emitter<DayState> emit) async {
    var day = await Hive.openBox<DayModel>("daysBox");
    var dayBox = Hive.box<DayModel>("daysBox");
    if (dayBox.isEmpty) {
      day.addAll(kDaysList);
    }
    emit(DayLoaded(
      days: dayBox,
    ));
  }

  void _onUpdateExerciseDayEvent(
      UpdateExerciseDayEvent event, Emitter<DayState> emit) {
    emit(DayLoading());
    Box<DayModel> days = Hive.box<DayModel>("daysBox");
    days.getAt(event.dayIndex)!.exercises![event.exerciseIndex].copyWith(
          reps: event.reps,
        );
    emit(
      DayLoaded(
        days: days,
      ),
    );
  }

  void _onDeleteExerciseDayEvent(
      DeleteExerciseDayEvent event, Emitter<DayState> emit) {
    emit(DayLoading());
    Box<DayModel> days = Hive.box<DayModel>("daysBox");
    ExerciseModel exercise =
        days.getAt(event.dayIndex)!.exercises!.removeAt(event.exerciseIndex);
    emit(
      DayLoaded(
        days: days,
      ),
    );
  }
}
