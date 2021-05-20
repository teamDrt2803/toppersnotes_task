import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:toppersnotes_task/modals/datamodal.dart';
import 'package:toppersnotes_task/utilities/constants.dart';
import 'package:get/get.dart';

import '../main.dart';

class DataController extends GetxController {
  final selectedIndex = 3.obs;
  final RxBool darkTheme = false.obs;
  @override
  Future<void> onInit() async {
    if (newsModalBox.isEmpty) {
      var modal = NewsModal.fromMap(NEWSDUMMYDATA);
      for (var item in modal.result) {
        var index = newsModalBox.values
            .toList()
            .indexWhere((element) => element == item);
        if (index == -1) newsModalBox.add(item);
      }
    }
    super.onInit();
  }
}
