// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ministries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ministries _$MinistriesFromJson(Map<String, dynamic> json) => Ministries(
      id: json['id'] as int,
      name: json['name'] as String,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$MinistriesToJson(Ministries instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
    };
