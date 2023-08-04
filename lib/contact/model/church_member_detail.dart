import 'package:json_annotation/json_annotation.dart';
import 'package:phonebook/contact/model/household.dart';
import 'package:phonebook/contact/model/ministries.dart';

part 'church_member_detail.g.dart';

@JsonSerializable()
class ChurchMemberDetail {
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
  final int? cellId;
  final int? cell;
  @JsonKey(name: "gathering_id")
  final int? gatheringId;
  @JsonKey(name: "gathering_name")
  final String? gatheringName;
  @JsonKey(name: "position_id")
  final int? positionId;
  @JsonKey(name: "position_name")
  final String? positionName;
  final int? parish;
  @JsonKey(name: 'parish_role')
  final String? parishRole;
  @JsonKey(name: 'cell_role')
  final String? cellRole;
  @JsonKey(name: 'gathering_role')
  final String? gatheringRole;
  List<HouseHold> household;
  List<Ministries> ministries;

  ChurchMemberDetail({
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
    required this.parishRole,
    required this.cellRole,
    required this.gatheringRole,
    required this.household,
    required this.ministries,
    required this.parish,
    required this.positionId,
    required this.positionName,
  });

  factory ChurchMemberDetail.fromJson(Map<String, dynamic> json) =>
      _$ChurchMemberDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ChurchMemberDetailToJson(this);
}
