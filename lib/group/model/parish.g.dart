// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parishes _$ParishesFromJson(Map<String, dynamic> json) => Parishes(
      parishes:
          (json['parishes'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ParishesToJson(Parishes instance) => <String, dynamic>{
      'parishes': instance.parishes,
    };
