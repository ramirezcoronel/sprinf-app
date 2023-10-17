// ignore: depend_on_referenced_packages
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:json_annotation/json_annotation.dart';

import 'dimension.dart';

part 'baremos.freezed.dart';
part 'baremos.g.dart';

@freezed
class Baremos with _$Baremos {
  const factory Baremos({
    required String nombre,
    required String dimensiones,
    List<Dimension>? infoDimensiones,
  }) = _Baremos;

  factory Baremos.fromJson(Map<String, dynamic> json) =>
      _$BaremosFromJson(json);
}
