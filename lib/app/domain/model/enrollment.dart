// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:json_annotation/json_annotation.dart';

part 'enrollment.freezed.dart';
part 'enrollment.g.dart';

@freezed
class Enrollment with _$Enrollment {
  const factory Enrollment({
    @JsonKey(name: 'id_inscripcion') required String id,
    @JsonKey(name: 'seccion_id') required String seccion,
    @JsonKey(name: 'codigo_materia') required String codigoMateria,
    @JsonKey(name: 'nombre_materia') required String nombreMateria,
    required String calificacion,
  }) = _Enrollment;

  factory Enrollment.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentFromJson(json);
}
