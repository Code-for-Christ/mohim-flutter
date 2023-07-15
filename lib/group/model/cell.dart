import 'package:json_annotation/json_annotation.dart';

part 'cell.g.dart';

@JsonSerializable()
class Cell {
  int id;
  int parish;
  int cell;
  @JsonKey(name: 'church_id')
  int churchId;

  Cell(
      {required this.id,
      required this.parish,
      required this.cell,
      required this.churchId});

  factory Cell.fromJson(Map<String, dynamic> json) => _$CellFromJson(json);
  Map<String, dynamic> toJson() => _$CellToJson(this);

  static List<Cell> fromJsonList(List list) {
    return list.map((item) => Cell.fromJson(item)).toList();
  }
}
