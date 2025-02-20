import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CallController extends GetxController {

  
  Future<void> callDriver(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri.parse("tel:$phoneNumber");
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw "Could not launch call";
      }
    } catch (e, stackrace) {
      debugPrint("${e.toString()} Trace: $stackrace");
    }
  }
}
