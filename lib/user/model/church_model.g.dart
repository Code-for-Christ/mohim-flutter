// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'church_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchModel _$ChurchModelFromJson(Map<String, dynamic> json) => ChurchModel(
      id: json['id'] as int,
      name: json['name'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$ChurchModelToJson(ChurchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
    };
