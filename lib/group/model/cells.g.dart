// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cells.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cells _$CellsFromJson(Map<String, dynamic> json) => Cells(
      cells: (json['cells'] as List<dynamic>)
          .map((e) => Cell.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CellsToJson(Cells instance) => <String, dynamic>{
      'cells': instance.cells,
    };
