// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['full_name'] as String,
      age: (json['age'] as num?)?.toInt() ?? 18,
      password: json['password'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      registeredAt: const EpochDateTimeConverter()
          .fromJson((json['registered_at'] as num).toInt()),
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.name,
      'age': instance.age,
      'registered_at':
          const EpochDateTimeConverter().toJson(instance.registeredAt),
      'address': instance.address?.toJson(),
      'status': _$UserStatusEnumMap[instance.status]!,
    };

const _$UserStatusEnumMap = {
  UserStatus.active: 1,
  UserStatus.inactive: 0,
  UserStatus.pending: -1,
};
