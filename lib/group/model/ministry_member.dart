import 'package:json_annotation/json_annotation.dart';

part 'ministry_member.g.dart';

@JsonSerializable()
class MinistryMember {
  final int id;
  final String name;
  @JsonKey(name: 'householder_id')
  final int householderId;
  @JsonKey(name: "relationship_with_householder")
  final String? relationshipWithHouseholder;
  @JsonKey(name: "birth_year")
  final int? birthYear;
  @JsonKey(name: "salvation_year")
  final int? salvationYear;
  @JsonKey(name: "salvation_month")
  final int? salvationMonth;
  @JsonKey(name: "salvation_day")
  final int? salvationDay;
  @JsonKey(name: "car_number")
  final String? carNumber;
  final String? sex;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? address;
  @JsonKey(name: "profile_image_thumbnail")
  final String? thumbnail;
  @JsonKey(name: 'church_id')
  final int churchId;
  @JsonKey(name: "church_name")
  final String chruchName;
  @JsonKey(name: 'cell_id')
  final int cellId;
  final int? cell;
  @JsonKey(name: "gathering_id")
  final int gatheringId;
  @JsonKey(name: "gathering_name")
  final String? gatheringName;
  @JsonKey(name: 'ministry_id')
  final int? ministryId;
  @JsonKey(name: 'ministry_name')
  final String? ministryName;
  @JsonKey(name: 'ministry_role')
  final String? ministryRole;

  MinistryMember({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.gatheringId,
    required this.householderId,
    required this.birthYear,
    required this.salvationYear,
    required this.salvationMonth,
    required this.salvationDay,
    required this.carNumber,
    required this.sex,
    required this.phoneNumber,
    required this.address,
    required this.cell,
    required this.cellId,
    required this.chruchName,
    required this.churchId,
    required this.gatheringName,
    required this.relationshipWithHouseholder,
    required this.ministryId,
    required this.ministryName,
    required this.ministryRole,
  });

  factory MinistryMember.fromJson(Map<String, dynamic> json) =>
      _$MinistryMemberFromJson(json);
  Map<String, dynamic> toJson() => _$MinistryMemberToJson(this);

  static List<MinistryMember> fromJsonList(List list) {
    return list.map((item) => MinistryMember.fromJson(item)).toList();
  }
}
