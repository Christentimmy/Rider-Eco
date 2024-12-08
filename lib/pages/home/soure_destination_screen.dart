import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/build_icon_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class SoureDestinationScreen extends StatefulWidget {
  const SoureDestinationScreen({super.key});

  @override
  State<SoureDestinationScreen> createState() => _SoureDestinationScreenState();
}

class _SoureDestinationScreenState extends State<SoureDestinationScreen> {
  final _fromController = TextEditingController();

  final _inputFields = RxList();

  @override
  void initState() {
    _inputFields.add(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30,
          ),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.05),
              Row(
                children: [
                  buildIconButton(
                    icon: Icons.arrow_back,
                    onTap: () {},
                    height: 55,
                    width: 55,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      hintText: "Soft bank",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 2,
                            color: AppColors.primaryColor,
                          )),
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      textController: _fromController,
                      bgColor: const Color(0xffDADADA),
                      suffixIcon: Icons.search,
                    ),
                  ),
                ],
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _inputFields.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ValueKey(index),
                      onDismissed: (direction) {
                        _inputFields.removeAt(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                
                                hintText: "location",
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                textController: _fromController,
                                bgColor: const Color(0xffF5F5F5),
                                suffixIcon: Icons.search,
                              ),
                            ),
                            index == _inputFields.length - 1
                                ? buildIconButton(
                                    icon: Icons.add,
                                    margin: const EdgeInsets.only(left: 10),
                                    onTap: () {
                                      _inputFields.add(null);
                                    },
                                    height: 55,
                                    width: 55,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
