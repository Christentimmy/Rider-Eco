import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:rider/resources/colors.dart';

class ChatCustomerServiceScreen extends StatelessWidget {
  ChatCustomerServiceScreen({super.key});

  final _typeController = TextEditingController();
  RxString _typed = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: AppColors.primaryColor,
                    ),
                    constraints: const BoxConstraints(
                      minHeight: 45,
                      maxWidth: 250,
                    ),
                    child: const Text(
                      "Hello Baby Girl, How're You sf ejh wasom uf wuwe spe bwew ofn ier krw ofrr sdhe wewej kde r weuwf fiowfr wiwe virk nnei dhe winfo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "3:45 PM",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Color(0xffEFEFF4),
                    ),
                    constraints: const BoxConstraints(
                      minHeight: 45,
                      maxWidth: 250,
                    ),
                    child: const Text(
                      "Hello Baby Girl, How're You sf ejh wo",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "3:45 PM",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F6FB),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        _typed.value = value;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Type here",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        // suffixIcon: Icon(
                        //   FontAwesomeIcons.paperPlane,
                        //   size: 18,
                        //   color: AppColors.primaryColor,
                        // ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Obx(
                  () => _typed.value.isEmpty
                      ? const CircleAvatar(
                          radius: 28,
                          backgroundColor: Color.fromARGB(255, 86, 187, 4),
                          child: Icon(
                            Icons.mic,
                            color: Colors.white,
                          ),
                        )
                      : const CircleAvatar(
                          radius: 28,
                          backgroundColor: Color.fromARGB(255, 86, 187, 4),
                          child: Icon(
                          FontAwesomeIcons.paperPlane,
                          size: 17,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Customer Service",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.call,
            color: Colors.black,
          ),
        )
      ],
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}
