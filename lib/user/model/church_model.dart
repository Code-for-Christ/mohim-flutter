import 'package:json_annotation/json_annotation.dart';

part 'church_model.g.dart';

@JsonSerializable()
class ChurchModel {
  final int id;
  final String name;
  final String country;

  ChurchModel({
    required this.id,
    required this.name,
    required this.country,
  });

  factory ChurchModel.fromJson(Map<String, dynamic> json) =>
      _$ChurchModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChurchModelToJson(this);

  static List<ChurchModel> fromJsonList(List list) {
    return list.map((item) => ChurchModel.fromJson(item)).toList();
  }
}
