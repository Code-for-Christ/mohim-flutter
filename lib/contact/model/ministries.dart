import 'package:json_annotation/json_annotation.dart';

part 'ministries.g.dart';

@JsonSerializable()
class Ministries {
  int id;
  String name;
  String? role;

  Ministries({
    required this.id,
    required this.name,
    required this.role,
  });

  factory Ministries.fromJson(Map<String, dynamic> json) =>
      _$MinistriesFromJson(json);
  Map<String, dynamic> toJson() => _$MinistriesToJson(this);
}
