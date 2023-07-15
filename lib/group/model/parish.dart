import 'package:json_annotation/json_annotation.dart';

part 'parish.g.dart';

@JsonSerializable()
class Parishes {
  List<int> parishes;

  Parishes({required this.parishes});

  factory Parishes.fromJson(Map<String, dynamic> json) =>
      _$ParishesFromJson(json);
  Map<String, dynamic> toJson() => _$ParishesToJson(this);
}
