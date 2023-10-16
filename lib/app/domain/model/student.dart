// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:json_annotation/json_annotation.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
class Student with _$Student {
  const factory Student({
    required int id,
    required String nombre,
    required String apellido,
    required String cedula,
    @JsonKey(name: 'proyecto_id') required int proyectoId,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
