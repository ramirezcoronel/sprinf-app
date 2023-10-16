// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:json_annotation/json_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project(
      {required int id,
      // @JsonKey(name: 'fase_id') required String faseId,
      required String nombre,
      required String comunidad,
      // @JsonKey(name: 'motor_productivo') required String motorProductivo,
      // required String resumen,
      required String direccion,
      // required String municipio,
      // required String parroquia,
      @JsonKey(name: 'tutor_ex') required String tutorEx,
      // @JsonKey(name: 'tutor_in') required String tutorIn,
      // required String cerrado,
      @JsonKey(name: 'tutor_in_nombre') required String tutorInNombre,
      @JsonKey(name: 'tutor_in_cedula') required String tutorInCedula,
      @JsonKey(name: 'nombre_trayecto') required String nombreTrayecto,
      @JsonKey(name: 'nombre_fase') required String nombreFase,
      @JsonKey(name: 'fecha_inicio') required String fechaInicio,
      @JsonKey(name: 'fecha_cierre') required String fechaCierre}) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}
