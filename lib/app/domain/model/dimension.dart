// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:json_annotation/json_annotation.dart';

import 'indicador.dart';

part 'dimension.freezed.dart';
part 'dimension.g.dart';

@freezed
class Dimension with _$Dimension {
  const factory Dimension({
    required String nombre,
    required String grupal,
    List<Indicador>? indicadores,
  }) = _Dimension;

  factory Dimension.fromJson(Map<String, dynamic> json) =>
      _$DimensionFromJson(json);
}
