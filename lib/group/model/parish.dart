import 'package:json_annotation/json_annotation.dart';

part 'parish.g.dart';

//flutter pub run build_runner build
@JsonSerializable()
class Parishes {
  List<int> parishes;

  Parishes({required this.parishes});

  factory Parishes.fromJson(Map<String, dynamic> json) =>
      _$ParishesFromJson(json);
  Map<String, dynamic> toJson() => _$ParishesToJson(this);
}
