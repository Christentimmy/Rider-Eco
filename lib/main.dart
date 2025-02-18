import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/bindings/app_bindings.dart';
import 'package:rider/controller/onesignal_controller.dart';
import 'package:rider/pages/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51QrKaD2fYqVtcus28JnXdX7eNT7Q5dYei3Gz16MfbC3n9uHoEegMzGjNISovjZca9Bta9dFEK7lLcgR6mam7yBLR00Uo4yzLkI";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  final oneSignalController = Get.put(OneSignalController());
  oneSignalController.initOneSignal();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      home: const SplashScreen(),
      initialBinding: AppBindings(),
    );
  }
}
