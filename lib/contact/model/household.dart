import 'package:json_annotation/json_annotation.dart';

part 'household.g.dart';

@JsonSerializable()
class HouseHold {
  int id;
  String name;
  @JsonKey(name: "householder_id")
  int? householderId;
  @JsonKey(name: "relationship_with_householder")
  String? relationshipWithHouseholder;
  @JsonKey(name: "phone_number")
  String? phoneNumber;
  @JsonKey(name: 'profile_image_thumbnail')
  String? profileImageThumbnail;

  HouseHold({
    required this.id,
    required this.name,
    required this.householderId,
    required this.relationshipWithHouseholder,
    required this.phoneNumber,
    required this.profileImageThumbnail,
  });

  factory HouseHold.fromJson(Map<String, dynamic> json) => _$HouseHoldFromJson(json);
  Map<String, dynamic> toJson() => _$HouseHoldToJson(this);
}
