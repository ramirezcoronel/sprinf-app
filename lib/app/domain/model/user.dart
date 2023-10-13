// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:json_annotation/json_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User(
      {required String email,
      required String nombre,
      required String apellido,
      required int rol,
      required int id}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
