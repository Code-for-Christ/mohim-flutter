import 'package:json_annotation/json_annotation.dart';

part 'ministry.g.dart';

@JsonSerializable()
class Ministry {
  int id;
  String name;
  @JsonKey(name: 'church_id')
  int churchId;

  Ministry(
      {required this.id,
      required this.name,
      required this.churchId});

  factory Ministry.fromJson(Map<String, dynamic> json) =>
      _$MinistryFromJson(json);
  Map<String, dynamic> toJson() => _$MinistryToJson(this);

  static List<Ministry> fromJsonList(List list) {
    return list.map((item) => Ministry.fromJson(item)).toList();
  }
}
