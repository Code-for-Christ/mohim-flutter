// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseHold _$HouseHoldFromJson(Map<String, dynamic> json) => HouseHold(
      id: json['id'] as int,
      name: json['name'] as String,
      householderId: json['householder_id'] as int?,
      relationshipWithHouseholder:
          json['relationship_with_householder'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profileImageThumbnail: json['profile_image_thumbnail'] as String?,
    );

Map<String, dynamic> _$HouseHoldToJson(HouseHold instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'householder_id': instance.householderId,
      'relationship_with_householder': instance.relationshipWithHouseholder,
      'phone_number': instance.phoneNumber,
      'profile_image_thumbnail': instance.profileImageThumbnail,
    };
