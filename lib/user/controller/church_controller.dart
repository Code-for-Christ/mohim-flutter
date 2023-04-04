import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:phonebook/user/model/church_model.dart';
import 'package:phonebook/user/service/church_service.dart';

class ChurchController extends GetxController {
  final churchService = ChurchService();
  final churchs = <ChurchModel>[].obs;

  @override
  onInit() async {
    await getChurches();
    super.onInit();
  }

  Future<void> getChurches() async {
    churchs.value = await churchService.getChurches();
  }
}
