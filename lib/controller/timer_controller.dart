
import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  RxInt secondsLeft = 30.obs;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }


  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  void startTimer(){
    secondsLeft.value = 30;
     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value < 1) {
        timer.cancel();
      } else {
        secondsLeft.value -= 1;
      }
    });
  }
}
