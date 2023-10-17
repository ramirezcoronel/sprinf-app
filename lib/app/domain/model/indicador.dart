// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:json_annotation/json_annotation.dart';

part 'indicador.freezed.dart';
part 'indicador.g.dart';

@freezed
class Indicador with _$Indicador {
  const factory Indicador({
    required String nombre,
    required String ponderacion,
  }) = _Indicador;

  factory Indicador.fromJson(Map<String, dynamic> json) =>
      _$IndicadorFromJson(json);
}
