import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/storage_controller.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/driver_model.dart';
import 'package:rider/pages/booking/trip_payment_screen.dart';
import 'package:rider/pages/home/trip_details_screen.dart';
import 'package:rider/utils/base_url.dart';
import 'package:rider/widgets/snack_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  IO.Socket? socket;
  RxList chatModelList = [].obs;
  RxList chatsList = [].obs;
  RxBool isloading = false.obs;
  final _userController = Get.find<UserController>();
  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;

  void initializeSocket() async {
    String? token = await StorageController().getToken();
    if (token == null) {
      return;
    }

    socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'Authorization': 'Bearer $token'},
      'reconnection': true,
      "forceNew": true,
    });

    socket?.connect();

    socket?.onConnect((_) {
      print("Socket connected successfully");
      listenToEvents();
    });

    socket?.onDisconnect((_) {
      print("Socket disconnected");
      scheduleReconnect();
      if (_reconnectAttempts >= _maxReconnectAttempts) {
        disConnectListeners();
      }
    });

    socket?.on('connect_error', (_) {
      print("Connection error");
      scheduleReconnect();
    });
  }

  void listenToEvents() {
    socket?.on("userDetails", (data) {
      debugPrint(data.toString());
    });

    socket?.on("rideAccepted", (data) {
      print(data);
      String roomId = data["data"]["ride"]["_id"];
      print(roomId);
      DriverModel driver = DriverModel.fromJson(data["data"]["driver"]);
      socket?.emit("joinRoom", {"roomId": roomId});
      debugPrint(data.toString());
      Get.to(() => TripDetailsScreen(driver: driver));
    });

    socket?.on('driverLocationUpdated', (data) {
      final lat = data['lat'];
      final lng = data['lng'];
      LatLng driverLocation = LatLng(lat, lng);
      print('Driver location updated: $lat, $lng');
      _userController.driverLocation.value = driverLocation;
      _userController.driverLocation.refresh();
    });

    socket?.on("tripStatus", (data) {
      String message = data["message"];
      if (message.contains("started")) {
        Get.to(() => const TripDetailsScreen());
      }
      if (message.contains("completed")) {
        Get.to(() => const TripPaymentScreen());
      }
    });

    socket?.on("rideCancelled", (data) {
      String message = data["message"];
      CustomSnackbar.showSuccessSnackBar(message);
    });
  }

  void disConnectListeners() async {
    if (socket != null) {
      socket?.off("userDetails");
      socket?.off("rideAccepted");
      socket?.off("driverLocationUpdated");
      socket?.off("tripStatus");
      socket?.off("rideCancelled");
    }
  }

  void disconnectSocket() {
    disConnectListeners();
    socket?.disconnect();
    socket = null;
    socket?.close();
    print('Socket disconnected and deleted');
  }

  void sendMessage(String message, String channedId) {
    final payload = {
      "channel_id": channedId,
      "message": message,
      "files": <String>[],
    };
    socket?.emit('SEND_MESSAGE', payload);
  }

  void markRead({
    required String channedId,
    required String messageId,
  }) async {
    socket?.emit("MARK_MESSAGE_READ", {
      "channel_id": channedId,
      "message_ids": [messageId],
    });
  }

  void scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      debugPrint("🚨 Max reconnection attempts reached. Stopping retry.");
      return;
    }

    int delay = 2 * _reconnectAttempts + 2;
    debugPrint("🔄 Reconnecting in $delay seconds...");

    Future.delayed(Duration(seconds: delay), () {
      _reconnectAttempts++;
      socket?.connect();
    });
  }

  @override
  void onClose() {
    socket?.dispose();
    super.onClose();
    socket = null;
  }
}
