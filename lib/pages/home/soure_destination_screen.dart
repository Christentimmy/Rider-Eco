import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/pages/home/find_a_ride_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/service/location_service.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';
import 'package:rider/widgets/snack_bar.dart';

class SoureDestinationScreen extends StatefulWidget {
  final String destination;
  final LatLng destinationLatLng;
  const SoureDestinationScreen({
    super.key,
    required this.destination,
    required this.destinationLatLng,
  });

  @override
  State<SoureDestinationScreen> createState() => _SoureDestinationScreenState();
}

class _SoureDestinationScreenState extends State<SoureDestinationScreen> {
  final _fromController = TextEditingController();
  final _inputFields = RxList();
  LatLng fromLocaion = const LatLng(0.0, 0.0);
  final RxString _fromLocationName = "".obs;

  final TextEditingController _searchController = TextEditingController();
  final RxList<Map<String, dynamic>> _places = <Map<String, dynamic>>[].obs;

  void searchPlaces(String query) async {
    List<Map<String, dynamic>> results = await LocationService.searchPlaces(
      query,
    );
    _places.value = results;
  }

  @override
  void initState() {
    _inputFields.add(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                const Text(
                  "To (Destination): ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                CustomTextField(
                  readOnly: true,
                  hintText: widget.destination,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 15),
                  textController: _fromController,
                  bgColor: const Color(0xffDADADA),
                  prefixIcon: Icons.search,
                ),
                const SizedBox(height: 20),
                const Text(
                  "From (Source): ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                CustomTextField(
                  onChanged: searchPlaces,
                  hintText: "From Where",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 15),
                  textController: _searchController,
                  bgColor: const Color(0xffDADADA),
                  prefixIcon: Icons.search,
                ),
                const SizedBox(height: 10),
                Obx(
                  () =>
                      _places.isEmpty
                          ? const SizedBox.shrink()
                          : ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: _places.length,
                            itemBuilder: (context, index) {
                              String title = _places[index]["name"] ?? "";
                              String lat = _places[index]["lat"] ?? "";
                              String lng = _places[index]["lon"] ?? "";
                              if (title.isEmpty || lat.isEmpty || lng.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return ListTile(
                                onTap: () {
                                  _searchController.clear();
                                  _searchController.text += title;
                                  _places.clear();

                                  fromLocaion = LatLng(
                                    double.parse(lat),
                                    double.parse(lng),
                                  );

                                  _fromLocationName.value = title;
                                },
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.timelapse_sharp),
                                title: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                ),
                const SizedBox(height: 30),
                CommonButton(
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ontap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_searchController.text.isEmpty) {
                      CustomSnackbar.showErrorSnackBar(
                        "Kindly fill the from field",
                      );
                      return;
                    }
                    print("Source Screen: $fromLocaion");

                    Get.to(
                      () => FindARideScreen(
                        fromLocaion: fromLocaion,
                        toLocation: widget.destinationLatLng,
                        fromLocationName: _fromLocationName.value,
                        toLocationName: widget.destination,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
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
                      child: Text(
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
                // _recentSearched(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ListView _recentSearched() {
  //   return ListView.builder(
  //     itemCount: 1,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemBuilder: (context, index) {
  //       return const ListTile(
  //         // onTap: () => Get.to(() => const FindARideScreen()),
  //         contentPadding: EdgeInsets.zero,
  //         leading: Icon(Icons.timelapse_sharp),
  //         title: Text(
  //           "Soft Bank",
  //           style: TextStyle(
  //             fontSize: 17,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         // subtitle: const Text("364 Stillwater Ave. Attleboro, MA 027"),
  //       );
  //     },
  //   );
  // }
}
