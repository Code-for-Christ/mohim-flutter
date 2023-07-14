// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cell _$CellFromJson(Map<String, dynamic> json) => Cell(
      id: json['id'] as int,
      parish: json['parish'] as int,
      cell: json['cell'] as int,
      churchId: json['church_id'] as int,
    );

Map<String, dynamic> _$CellToJson(Cell instance) => <String, dynamic>{
      'id': instance.id,
      'parish': instance.parish,
      'cell': instance.cell,
      'church_id': instance.churchId,
    };
