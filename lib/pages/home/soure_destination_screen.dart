import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/find_a_ride_screen.dart';
import 'package:rider/resources/colors.dart';
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
              _buildFromLocationField(),
              const SizedBox(height: 10),
              _buildToLocations(),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Text(
                    'Recent',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      _inputFields.clear();
                      _inputFields.add(null);
                      _inputFields.refresh();
                    },
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              _recentSearched(),
            ],
          ),
        ),
      ),
    );
  }

  ListView _recentSearched() {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => Get.to(() => FindARideScreen()),
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.timelapse_sharp),
          title: const Text(
            "Soft Bank",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text("364 Stillwater Ave. Attleboro, MA 027"),
        );
      },
    );
  }

  Obx _buildToLocations() {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _inputFields.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Dismissible(
              key: UniqueKey(),
              direction: _inputFields.length - 1 != 0
                  ? DismissDirection.endToStart
                  : DismissDirection.none,
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                _inputFields.removeAt(index);
              },
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Location",
                      prefixIcon: Icons.search,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      textController: _fromController,
                      bgColor: const Color(0xffF5F5F5),
                    ),
                  ),
                  if (index == _inputFields.length - 1)
                    IconButton(
                      onPressed: () {
                        _inputFields.add(null);
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row _buildFromLocationField() {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: Container(
            height: 45,
            width: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
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
            prefixIcon: Icons.search,
          ),
        ),
      ],
    );
  }
}
