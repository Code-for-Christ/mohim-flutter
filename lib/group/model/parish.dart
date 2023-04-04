import 'package:json_annotation/json_annotation.dart';

part 'parish.g.dart';

//flutter pub run build_runner build
@JsonSerializable()
class Parish {
  int parish;

  Parish({required this.parish});

  factory Parish.fromJson(Map<String, dynamic> json) => _$ParishFromJson(json);
  Map<String, dynamic> toJson() => _$ParishToJson(this);

  static List<Parish> fromJsonList(List list) {
    return list.map((item) => Parish.fromJson(item)).toList();
  }
}
