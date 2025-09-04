import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum UserStatus {
  @JsonValue(1)
  active,
  @JsonValue(0)
  inactive,
  @JsonValue(-1)
  pending,
}
/// Enhanced enum
@JsonEnum(valueField: 'code') // Chỉ định lấy field `code` làm giá trị
enum UserStatusEnhanced {
  active(200, 'Active and verified'),
  inactive(404, 'Not found'),
  suspended(500, 'Suspended due to policy');

  const UserStatusEnhanced(this.code, this.description);
  final int code;
  final String description;
}