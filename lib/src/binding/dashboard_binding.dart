
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';
import '../data/repository/main_repository.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() {
      return DashboardController(
          repository: MainRepository());
    });
  }
}

