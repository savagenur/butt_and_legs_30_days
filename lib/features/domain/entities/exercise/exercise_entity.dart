import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable  {
  final String? name;
  final String? description;
  final int? reps;
  final String? imagePath;
  const ExerciseEntity({
    this.name,
    this.description,
    this.reps,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        reps,
        imagePath,
      ];
}
