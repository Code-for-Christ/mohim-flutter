// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ministry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ministry _$MinistryFromJson(Map<String, dynamic> json) => Ministry(
      id: int.parse(json['id']),
      name: json['name'] as String,
      category: json['category'] as String,
      churchId: int.parse(json['church_id']),
    );

Map<String, dynamic> _$MinistryToJson(Ministry instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'church_id': instance.churchId,
    };
