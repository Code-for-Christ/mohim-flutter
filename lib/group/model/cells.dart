import 'package:json_annotation/json_annotation.dart';
import 'package:phonebook/group/model/cell.dart';

part 'cells.g.dart';

@JsonSerializable()
class Cells {
  List<Cell> cells;

  Cells(
      {required this.cells});

  factory Cells.fromJson(Map<String, dynamic> json) => _$CellsFromJson(json);
  Map<String, dynamic> toJson() => _$CellsToJson(this);

}
