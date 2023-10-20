import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {
  int id;
  String name;
  @JsonKey(name: 'church_id')
  int churchId;

  Position({
    required this.id,
    required this.name,
    required this.churchId,
  });

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);

  static List<Position> fromJsonList(List list) {
    return list.map((item) => Position.fromJson(item)).toList();
  }
}
