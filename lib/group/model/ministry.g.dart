// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ministry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ministry _$MinistryFromJson(Map<String, dynamic> json) => Ministry(
      id: json['id'].runtimeType == int ? json['id'] : int.parse(json['id']),
      name: json['name'] as String,
      churchId: json['church_id'].runtimeType == int
          ? json['church_id']
          : int.parse(json['church_id']),
    );

Map<String, dynamic> _$MinistryToJson(Ministry instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'church_id': instance.churchId,
    };
