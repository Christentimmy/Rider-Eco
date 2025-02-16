import 'package:get/get.dart';
import 'package:rider/controller/auth_controller.dart';
import 'package:rider/controller/storage_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageController());
    Get.put(AuthController());
  }
}
