// import 'package:rider/controller/storage_controller.dart';
// import 'package:rider/controller/user_controller.dart';
// import 'package:rider/pages/auth/signup_screen.dart';
// import 'package:rider/pages/intro/intro_screen.dart';
// import 'package:rider/resources/color_resources.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final _storageController = Get.find<StorageController>();
//   final _userController = Get.find<UserController>();

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 5), () async {
//       bool newUser = await _storageController.getUserStatus();
//       if (newUser) {
//         Get.offAll(() => IntroScreen());
//         await _storageController.saveStatus("notNewAgain");
//         return;
//       }
//       String? token = await _storageController.getToken();
//       if (token == null) {
//         Get.off(() => SignUpScreen());
//         return;
//       }
//       await _userController.getUserStatus();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Image.asset(
//               "assets/images/ecoLogo.png",
//               width: 220,
//               fit: BoxFit.cover,
//             ),
//           ),
//           _buildSplashText(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSplashText() {
//     return Column(
//       children: AnimationConfiguration.toStaggeredList(
//         childAnimationBuilder: (widget) => SlideAnimation(
//           verticalOffset: 50.0,
//           child: FadeInAnimation(
//             child: widget,
//           ),
//         ),
//         children: [
//           const SizedBox(height: 100),
//           const Text(
//             "Drive with ECO",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "Support your living with extra Cash",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ],
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
// }
