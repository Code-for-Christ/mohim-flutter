// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'church_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchModel _$ChurchModelFromJson(Map<String, dynamic> json) => ChurchModel(
      id: int.parse(json['id']),
      name: json['name'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$ChurchModelToJson(ChurchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
    };
