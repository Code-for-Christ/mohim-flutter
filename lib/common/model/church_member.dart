import 'package:json_annotation/json_annotation.dart';

part 'church_member.g.dart';

//flutter pub run build_runner build
@JsonSerializable()
class ChurchMember {
  // "id": 0,
  // "name": "string",
  // "householder_id": 0,
  // "relationship_with_householder": "string",
  // "birth_year": 0,
  // "salvation_year": 0,
  // "salvation_month": 0,
  // "salvation_day": 0,
  // "car_number": "string",
  // "sex": "male",
  // "phone_number": "string",
  // "address": "string",
  // "profile_image_thumbnail": "string",
  // "church_id": 0,
  // "church_name": "string",
  // "cell_id": 0,
  // "cell": 0,
  // "gathering_id": 0,
  // "gathering_name": "string"
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

  ChurchMember(
      {required this.id,
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
      required this.relationshipWithHouseholder});

  factory ChurchMember.fromJson(Map<String, dynamic> json) =>
      _$ChurchMemberFromJson(json);
  Map<String, dynamic> toJson() => _$ChurchMemberToJson(this);

  static List<ChurchMember> fromJsonList(List list) {
    return list.map((item) => ChurchMember.fromJson(item)).toList();
  }
}
