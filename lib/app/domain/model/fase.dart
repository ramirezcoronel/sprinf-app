// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:json_annotation/json_annotation.dart';

import 'baremos.dart';

part 'fase.freezed.dart';
part 'fase.g.dart';

@freezed
class Fase with _$Fase {
  const factory Fase(
      {@JsonKey(name: 'nombre_trayecto') required String nombreTrayecto,
      @JsonKey(name: 'nombre_fase') required String nombreFase,
      @JsonKey(name: 'fecha_inicio') required String fechaInicio,
      @JsonKey(name: 'fecha_cierre') required String fechaCierre,
      List<Baremos>? baremos}) = _Fase;

  factory Fase.fromJson(Map<String, dynamic> json) => _$FaseFromJson(json);
}
