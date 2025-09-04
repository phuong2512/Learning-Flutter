import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:learning_flutter/flutter/api/json/automated/date_time_convert.dart';
import 'address.dart';
import 'user_status.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String id;

  @JsonKey(name: 'full_name') // ánh xạ tên trường trong json
  final String name;

  @JsonKey(defaultValue: 18)  // giá trị mặc định
  final int age;

  @JsonKey(includeToJson: false)  // bỏ qua trường này, không serialize ra json
  final String? password;

  // @JsonKey(name: 'registered_at')
  @EpochDateTimeConverter() // Áp dụng custom converter cho field này
  final DateTime registeredAt;

  final Address? address;
  final UserStatus status;

  User({
    required this.id,
    required this.name,
    required this.age,
    this.password,
    this.address,
    required this.registeredAt,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}
