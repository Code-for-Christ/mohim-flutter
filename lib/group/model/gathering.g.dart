// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gathering.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gathering _$GatheringFromJson(Map<String, dynamic> json) => Gathering(
      id: json['id'].runtimeType == int ? json['id'] : int.parse(json['id']),
      name: json['name'] as String,
      churchId: json['church_id'].runtimeType == int
          ? json['church_id']
          : int.parse(json['church_id']),
    );

Map<String, dynamic> _$GatheringToJson(Gathering instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'church_id': instance.churchId,
    };
