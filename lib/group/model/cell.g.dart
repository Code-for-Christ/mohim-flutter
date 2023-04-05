// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cell _$CellFromJson(Map<String, dynamic> json) => Cell(
      id: int.parse(json['id']),
      parish: int.parse(json['parish']),
      cell: int.parse(json['cell']),
      churchId: int.parse(json['church_id']),
    );

Map<String, dynamic> _$CellToJson(Cell instance) => <String, dynamic>{
      'id': instance.id,
      'parish': instance.parish,
      'cell': instance.cell,
      'church_id': instance.churchId,
    };
