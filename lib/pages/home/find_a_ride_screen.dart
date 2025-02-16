import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/pages/home/available_vehicles_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/build_icon_button.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class FindARideScreen extends StatefulWidget {
  final LatLng fromLocaion;
  final LatLng toLocation;
  final String fromLocationName;
  final String toLocationName;
  const FindARideScreen({
    super.key,
    required this.fromLocaion,
    required this.toLocation,
    required this.fromLocationName,
    required this.toLocationName,
  });

  @override
  State<FindARideScreen> createState() => _FindARideScreenState();
}

class _FindARideScreenState extends State<FindARideScreen> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  RxString basePrice = "\$5000".obs;
  RxString estimatedTime = "".obs;

  @override
  void initState() {
    super.initState();
    _setMarkers();
    _getPolyline();
  }

  void _setMarkers() {
    _markers.add(Marker(
      markerId: const MarkerId("start"),
      position: widget.fromLocaion,
      infoWindow: const InfoWindow(title: "Start Location"),
    ));
    _markers.add(Marker(
      markerId: const MarkerId("end"),
      position: widget.toLocation,
      infoWindow: const InfoWindow(title: "End Location"),
    ));
    setState(() {});
  }

  Future<void> _getPolyline() async {
    final String url =
        "https://us1.locationiq.com/v1/directions/driving/${widget.fromLocaion.longitude},${widget.fromLocaion.latitude};${widget.toLocation.longitude},${widget.toLocation.latitude}?key=pk.d074964679caaa4f8b75ed81cd6b038a&overview=full&geometries=geojson";

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data.containsKey("routes") && data["routes"].isNotEmpty) {
      List<LatLng> polylineCoordinates = [];

      var route = data["routes"][0]["geometry"]["coordinates"];
      for (var point in route) {
        polylineCoordinates.add(
          LatLng(point[1], point[0]),
        );
      }

      var distanceInMeters = data["routes"][0]["distance"];
      var durationInSeconds = data["routes"][0]["duration"];

      double distanceInKm = distanceInMeters / 1000;
      double durationInMinutes = durationInSeconds / 60;

      estimatedTime.value = "${durationInMinutes.toStringAsFixed(2)} min";
      basePrice.value = (distanceInKm * 5000).toStringAsFixed(2);

      setState(() {
        _polylines.add(Polyline(
          polylineId: const PolylineId("route"),
          color: Colors.blue,
          width: 5,
          points: polylineCoordinates,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height * 0.65,
            width: Get.width,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: widget.fromLocaion,
                zoom: 15,
              ),
              markers: _markers,
              polylines: _polylines,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 50,
            ),
            child: buildIconButton(
              icon: Icons.arrow_back,
              onTap: () => Get.back(),
            ),
          ),
          _buildBottomWidget(),
        ],
      ),
    );
  }

  Widget _buildBottomWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.43,
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff22272B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListTile(
              title: widget.fromLocationName,
              icon: Icons.location_searching_sharp,
            ),
            _buildListTile(
              title: widget.toLocationName,
              icon: Icons.location_on,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "Price:  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Obx(
                  () => Text(
                    basePrice.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text(
                  "Trip duration:  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Obx(
                  () => Text(
                    estimatedTime.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CommonButton(
              text: "Find a ride",
              ontap: () {
                // Get.to(() => RequestRideScreen());

                Get.to(
                  () => AvailableVehiclesScreen(
                    fromLocaton: widget.fromLocaion,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile({
    required String title,
    required IconData icon,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minTileHeight: 40,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
