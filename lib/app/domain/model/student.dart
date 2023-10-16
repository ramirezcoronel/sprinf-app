// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:json_annotation/json_annotation.dart';
import 'package:sprinf_app/app/domain/model/enrollment.dart';
import 'package:sprinf_app/app/domain/model/project.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
class Student with _$Student {
  const factory Student({
    required String id,
    required String nombre,
    required String apellido,
    required String cedula,
    required String direccion,
    required String telefono,
    String? email,
    required Project? proyecto,
    List<Enrollment>? inscripciones,
    @JsonKey(name: 'proyecto_id') required String proyectoId,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
