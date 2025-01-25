
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "License",
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 final String text =
      """ Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin auctor faucibus viverra. Sed ultricies nunc sit amet massa ullamcorper auctor. Mauris lectus risus, sollicitudin at nulla et, faucibus ultrices mauris. Vivamus sit amet nulla eleifend, dignissim orci nec, volutpat ante. Nam a diam et nisl mattis efficitur. Donec nisl lorem, sollicitudin et semper eu, malesuada congue felis. In porta lacus id ante convallis ornare. Praesent eu est justo. Sed aliquam dui nec metus ultricies, ut interdum quam fermentum. Morbi lacus velit, vestibulum vel tortor non, posuere pulvinar augue. Donec nec sem sit amet ipsum ornare vulputate. Nam sollicitudin condimentum malesuada. Cras vulputate ante a orci sodales ultrices. Mauris accumsan aliquet volutpat.
Quisque ut tellus ipsum. Phasellus gravida magna lacus, id sodales velit suscipit sed. Cras varius libero vel mauris facilisis bibendum eget eu augue. Aenean quis nulla fermentum, rhoncus arcu nec, efficitur quam. Sed consequat velit nec ligula placerat, sit amet tempor sapien semper. Vestibulum blandit nisl in sem maximus blandit. Phasellus enim mi, scelerisque dapibus justo ut, malesuada facilisis mauris. Proin mollis quis lectus a tincidunt. In laoreet iaculis nulla vel gravida. Vivamus semper imperdiet leo. Aenean elementum erat et placerat eleifend. Proin leo mi, venenatis vel ultricies faucibus, vehicula a augue. Proin nisl dolor, dapibus sed vulputate et, pharetra quis lectus. Praesent leo libero, euismod sed hendrerit id, efficitur sit amet orci. Morbi quis justo nec orci dapibus euismod.
Morbi iaculis, nisl eu interdum faucibus, turpis turpis cursus libero, sit amet tincidunt tortor erat eu orci. Phasellus semper sollicitudin vulputate. Phasellus ac imperdiet justo. Vivamus sit amet pellentesque purus. Vivamus quis metus interdum felis tristique condimentum a vel augue. Integer porttitor dui non accumsan porttitor. Nulla quis lacus eget lorem faucibus eleifend ac id tortor. Nunc porttitor leo in fringilla sagittis. Nulla a ipsum quis turpis facilisis varius. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec sit amet convallis nibh, ac pretium dui. Phasellus sed est non est aliquam vestibulum. Donec elementum scelerisque diam, a dignissim dui hendrerit ut. Phasellus eros mauris, placerat iaculis scelerisque ac, tempus lobortis nisl. Interdum et malesuada fames ac ante ipsum primis in faucibus.
Pellentesque odio risus, malesuada non mollis et, malesuada venenatis est. Sed placerat purus ac tortor luctus vestibulum. Sed aliquet elit dolor, in aliquam diam vestibulum a. Morbi a tristique libero. Duis consectetur tincidunt finibus. Donec congue convallis augue, sit amet vestibulum libero porttitor in. Morbi sit amet enim sit amet ligula mollis consectetur a ac tellus. Nullam ultricies ligula eget quam egestas, eu commodo purus feugiat. Suspendisse sit amet congue ante. Curabitur aliquet ex at nunc porttitor semper. Donec gravida luctus eros, a cursus purus ullamcorper ut.
Proin aliquam sapien id justo ultricies commodo. Praesent at commodo magna, hendrerit venenatis quam. Proin volutpat feugiat nunc eget pellentesque. Donec at libero tempus, auctor libero eu, scelerisque odio. Vivamus varius ultricies augue, id tincidunt felis mattis suscipit. Duis imperdiet tincidunt ex ac fringilla. In in tristique sem. Morbi placerat purus id euismod accumsan. Aliquam erat volutpat. Suspendisse potenti. Ut interdum suscipit lectus eget volutpat. """;
}
