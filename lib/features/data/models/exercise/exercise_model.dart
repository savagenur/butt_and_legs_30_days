import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/entities/exercise/exercise_entity.dart';

import 'package:hive/hive.dart';

part 'exercise_model.g.dart';

@HiveType(typeId: 1)
class ExerciseModel extends ExerciseEntity with HiveObjectMixin {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final int? reps;
  @HiveField(3)
  final String? imagePath;
  ExerciseModel({
    this.name,
    this.description,
    this.reps,
    this.imagePath,
  }) : super(
          name: name,
          description: description,
          reps: reps,
          imagePath: imagePath,
        );

  ExerciseModel copyWith({
    String? name,
    String? description,
    int? reps,
    String? imagePath,
  }) {
    return ExerciseModel(
      name: name ?? this.name,
      description: description ?? this.description,
      reps: reps ?? this.reps,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
