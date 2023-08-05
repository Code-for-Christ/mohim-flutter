import 'package:get/get.dart';
import 'package:phonebook/common/config/config.dart';
import 'package:phonebook/common/dio/dio.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/group/model/cell.dart';
import 'package:phonebook/group/model/gathering.dart';
import 'package:phonebook/group/model/ministry.dart';
import 'package:phonebook/group/model/ministry_member.dart';
import 'package:phonebook/group/model/parish.dart';
import 'package:dio/dio.dart';
import 'package:phonebook/group/model/position.dart';

class GroupService {
  final url = '${Config.instance.baseUrl}/churches';

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
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> getCellMembers({
    required int churchId,
    required int cellId,
    required int page,
    required int size,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members?cell_id=$cellId&page=$page&size=$size&order_by=householder_id&name',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final members = ChurchMember.fromJsonList(resp.data['church_members']);
      return {
        'result': true,
        'members': members,
        'next': resp.data['metadata']['next_url']
      };
    } catch (e) {
      return {'result': false, 'members': []};
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
      print(e);
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

  Future<List<Position>> getPositionList({required int churchId}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/positions',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final positions = Position.fromJsonList(resp.data['positions']);
      return positions;
    } catch (e) {
      return [];
    }
  }

  Future<List<MinistryMember>> getMinistryMembers({
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
      final members = MinistryMember.fromJsonList(resp.data['church_members']);

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

  Future<Map<String, dynamic>> getGatheringMembers({
    required int churchId,
    required int gatheringId,
    required int page,
    required int size,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members?gathering_id=$gatheringId&page=$page&size=$size&order_by=name',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final members = ChurchMember.fromJsonList(resp.data['church_members']);
      return {
        'result': true,
        'members': members,
        'next': resp.data['metadata']['next_url']
      };
    } on DioError catch (e) {
      if (e.message.contains('Network')) {
        Get.rawSnackbar(
          message: '네트워크를 연결해주세요',
          animationDuration: Duration(milliseconds: 400),
        );
      }
      return {'result': false, 'members': []};
    }
  }

  Future<Map<String, dynamic>> getPositionMembers({
    required int churchId,
    required int positionId,
    required int page,
    required int size,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members?position_id=$positionId&page=$page&size=$size',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final members = ChurchMember.fromJsonList(resp.data['church_members']);
      return {
        'result': true,
        'members': members,
        'next': resp.data['metadata']['next_url']
      };
    } catch (e) {
      return {'result': false, 'members': []};
    }
  }

  Future<List<ChurchMember>> getParishLeaders({
    required int churchId,
    required int parish,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/parishes/$parish/leaders',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final parishLeaders =
          ChurchMember.fromJsonList(resp.data['church_members']);
      return parishLeaders;
    } catch (e) {
      return [];
    }
  }

  Future<List<ChurchMember>> getCellLeaders({
    required int churchId,
    required int cellId,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/cells/$cellId/leaders',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final cellLeaders =
          ChurchMember.fromJsonList(resp.data['church_members']);
      return cellLeaders;
    } catch (e) {
      return [];
    }
  }

  Future<List<MinistryMember>> getMinistryLeaders({
    required int churchId,
    required int ministryId,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/ministries/$ministryId/leaders',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final members = MinistryMember.fromJsonList(resp.data['church_members']);

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

  Future<List<ChurchMember>> getGatheringLeaders({
    required int churchId,
    required int gatheringId,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/gatherings/$gatheringId/leaders',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final gatheringLeaders =
          ChurchMember.fromJsonList(resp.data['church_members']);
      return gatheringLeaders;
    } catch (e) {
      return [];
    }
  }
}
