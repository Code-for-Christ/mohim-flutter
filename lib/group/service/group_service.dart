import 'package:get/get.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/dio/dio.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/group/model/cell.dart';
import 'package:phonebook/group/model/cells.dart';
import 'package:phonebook/group/model/gathering.dart';
import 'package:phonebook/group/model/ministry.dart';
import 'package:phonebook/group/model/ministry_role.dart';
import 'package:phonebook/group/model/parish.dart';
import 'package:dio/dio.dart';

class GroupService {
  final url = 'http://$ip/churches';

  Future<List<int>> getParishList({required int churchId}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get('$url/$churchId/parishes',
          options: Options(
            headers: {
              'content-type': 'application/json',
              'accessToken': 'true',
            },
          ));
      final parishes = Parishes.fromJson(resp.data);
      return parishes.parishes;
    } catch (e) {
      return [];
    }
  }

  Future<List<Cell>> getCellList({required int churchId}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/cells',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final cells = Cell.fromJsonList(resp.data['cells']);
      return cells;
    } catch (e) {
      return [];
    }
  }

  Future<List<ChurchMember>> getCellMembers({
    required int churchId,
    required int cellId,
    required int page,
    required int size,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members?cell_id=$cellId&page=$page&size=$size&order_by=householder_id',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final members = ChurchMember.fromJsonList(resp.data['church_members']);
      return members;
    } catch (e) {
      return [];
    }
  }

  Future<List<Ministry>> getMinistryList({required int churchId}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/ministries',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final ministries = Ministry.fromJsonList(resp.data['ministries']);
      return ministries;
    } catch (e) {
      return [];
    }
  }

  Future<List<Gathering>> getGatheringList({required int churchId}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/gatherings',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final gatherings = Gathering.fromJsonList(resp.data['gatherings']);
      return gatherings;
    } catch (e) {
      return [];
    }
  }

  Future<List<ChurchMember>> getMinistryMembers({
    required int churchId,
    required int ministryId,
    required int page,
    required int size,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/ministries/$ministryId/members',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final members = ChurchMember.fromJsonList(resp.data['church_members']);
      return members;
    } on DioError catch (e) {
      if (e.message.contains('Network')) {
        Get.rawSnackbar(
          message: '네트워크를 연결해주세요',
          animationDuration: Duration(milliseconds: 400),
        );
      }
      return [];
    }
  }

  Future<List<ChurchMember>> getGatheringMembers({
    required int churchId,
    required int gatheringId,
    required int page,
    required int size,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members?gathering_id=$gatheringId&page=$page&size=$size&order_by=householder_id',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final members = ChurchMember.fromJsonList(resp.data['church_members']);
      return members;
    } on DioError catch (e) {
      if (e.message.contains('Network')) {
        Get.rawSnackbar(
          message: '네트워크를 연결해주세요',
          animationDuration: Duration(milliseconds: 400),
        );
      }
      return [];
    }
  }

  
}
