part of 'day_bloc.dart';

abstract class DayState extends Equatable {
  const DayState();

  @override
  List<Object> get props => [];
}

class DayInitial extends DayState {
  @override
  List<Object> get props => [];
}

class DayLoaded extends DayState {
  final Box<DayModel> days;
  const DayLoaded({
    required this.days,
  });
  @override
  List<Object> get props => [
        days,
      ];
}

class DayLoading extends DayState {
  @override
  List<Object> get props => [];
}

class DayFailure extends DayState {
  @override
  List<Object> get props => [];
}
