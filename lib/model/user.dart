import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(includeIfNull: false)
class User extends Equatable {
  final String? fullName;

  final String email;

  final String? password;

  User({
    this.fullName,
    required this.email,
    this.password,
  });

  @override
  List<Object?> get props => [fullName, email, password];
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
