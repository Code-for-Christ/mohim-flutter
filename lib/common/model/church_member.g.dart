// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'church_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChurchMember _$ChurchMemberFromJson(Map<String, dynamic> json) => ChurchMember(
      id: json['id'] as int,
      name: json['name'] as String,
      thumbnail: json['profile_image_thumbnail'] as String?,
      gatheringId: json['gathering_id'] as int,
      householderId: json['householder_id'] as int,
      birthYear: json['birth_year'] as int?,
      salvationYear: json['salvation_year'] as int?,
      salvationMonth: json['salvation_month'] as int?,
      salvationDay: json['salvation_day'] as int?,
      carNumber: json['car_number'] as String?,
      sex: json['sex'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      cell: json['cell'] as int?,
      cellId: json['cell_id'] as int,
      chruchName: json['church_name'] as String,
      churchId: json['church_id'] as int,
      gatheringName: json['gathering_name'] as String?,
      relationshipWithHouseholder:
          json['relationship_with_householder'] as String?,
    );

Map<String, dynamic> _$ChurchMemberToJson(ChurchMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'householder_id': instance.householderId,
      'relationship_with_householder': instance.relationshipWithHouseholder,
      'birth_year': instance.birthYear,
      'salvation_year': instance.salvationYear,
      'salvation_month': instance.salvationMonth,
      'salvation_day': instance.salvationDay,
      'car_number': instance.carNumber,
      'sex': instance.sex,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'profile_image_thumbnail': instance.thumbnail,
      'church_id': instance.churchId,
      'church_name': instance.chruchName,
      'cell_id': instance.cellId,
      'cell': instance.cell,
      'gathering_id': instance.gatheringId,
      'gathering_name': instance.gatheringName,
    };
