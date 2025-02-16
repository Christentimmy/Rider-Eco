import 'package:get/get.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/utils/base_url.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService extends GetxController {
  late io.Socket socket;
  final userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    connect();
  }

  void connect({String? id}) async {
    await userController.getUserDetails();

    socket = io.io("ws://192.168.187.219:5000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      "forceNew": true,
      'query': {
        'id': id ?? userController.userModel.value?.id,
      },
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to Socket.IO server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from Socket.IO server');
    });

    socket.on('userDetails', (data) {
      print('Received data: $data');
    });

    socket.on("rideAccepted", (data) {
      print('Received data: $data');
    });

    socket.on('tripStatus', (data) {
      print('Received data: $data');
    });
  }

  void sendMessage(String message) {
    socket.emit('your-event', message);
  }

  void disconnect() {
    socket.disconnect();
  }
}
