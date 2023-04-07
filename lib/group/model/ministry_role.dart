import 'package:json_annotation/json_annotation.dart';

part 'ministry_role.g.dart';

@JsonSerializable()
class MinistryRole {
  @JsonKey(name: 'ministry_id')
  int ministryId;
  @JsonKey(name: 'ministry_name')
  String ministryName;
  @JsonKey(name: 'ministry_role')
  String ministryRole;

  MinistryRole({
    required this.ministryId,
    required this.ministryName,
    required this.ministryRole,
  });

  factory MinistryRole.fromJson(Map<String, dynamic> json) =>
      _$MinistryRoleFromJson(json);
  Map<String, dynamic> toJson() => _$MinistryRoleToJson(this);

  static List<MinistryRole> fromJsonList(List list) {
    return list.map((item) => MinistryRole.fromJson(item)).toList();
  }
}
