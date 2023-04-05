import 'package:json_annotation/json_annotation.dart';

part 'gathering.g.dart';

//flutter pub run build_runner build
@JsonSerializable()
class Gathering {
  int id;
  String name;
  @JsonKey(name: 'church_id')
  int churchId;

  Gathering(
      {required this.id,
      required this.name,
      required this.churchId});

  factory Gathering.fromJson(Map<String, dynamic> json) =>
      _$GatheringFromJson(json);
  Map<String, dynamic> toJson() => _$GatheringToJson(this);

  static List<Gathering> fromJsonList(List list) {
    return list.map((item) => Gathering.fromJson(item)).toList();
  }
}
