// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cell _$CellFromJson(Map<String, dynamic> json) => Cell(
      id: json['id'].runtimeType == int ? json['id'] : int.parse(json['id']),
      parish: json['parish'].runtimeType == int
          ? json['parish']
          : int.parse(json['parish']),
      cell: json['cell'].runtimeType == int
          ? json['cell']
          : int.parse(json['cell']),
      churchId: json['church_id'].runtimeType == int
          ? json['church_id']
          : int.parse(json['church_id']),
    );

Map<String, dynamic> _$CellToJson(Cell instance) => <String, dynamic>{
      'id': instance.id,
      'parish': instance.parish,
      'cell': instance.cell,
      'church_id': instance.churchId,
    };
