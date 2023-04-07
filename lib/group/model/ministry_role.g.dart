// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ministry_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinistryRole _$MinistryRoleFromJson(Map<String, dynamic> json) => MinistryRole(
      ministryId: json['ministry_id'] as int,
      ministryName: json['ministry_name'] as String,
      ministryRole: json['ministry_role'] as String,
    );

Map<String, dynamic> _$MinistryRoleToJson(MinistryRole instance) =>
    <String, dynamic>{
      'ministry_id': instance.ministryId,
      'ministry_name': instance.ministryName,
      'ministry_role': instance.ministryRole,
    };
