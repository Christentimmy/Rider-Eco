import 'package:get/get.dart';
import 'package:rider/controller/auth_controller.dart';
import 'package:rider/controller/onesignal_controller.dart';
import 'package:rider/controller/socket_controller.dart';
import 'package:rider/controller/storage_controller.dart';
import 'package:rider/controller/user_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(OneSignalController());
    Get.put(StorageController());
    Get.put(UserController());
    Get.put(SocketController());
    Get.put(AuthController());
  }
}
