import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/driver_model.dart';
import 'package:rider/models/ride_model.dart';
import 'package:rider/widgets/custom_button.dart';

class RideHistoryDetailsScreen extends StatefulWidget {
  final Ride ride;
  const RideHistoryDetailsScreen({
    super.key,
    required this.ride,
  });

  @override
  State<RideHistoryDetailsScreen> createState() =>
      _RideHistoryDetailsScreenState();
}

class _RideHistoryDetailsScreenState extends State<RideHistoryDetailsScreen> {
  final _userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDriver();
    });
  }

  void getDriver() async {
    final driver = await _userController.getDriverWithId(
      driverId: widget.ride.driverId!,
    );
    if (driver != null) {
      _driverModel.value = driver;
    }
  }

  final Rxn<DriverModel> _driverModel = Rxn<DriverModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.ride.pickupLocation?.lat ?? 0.0,
                widget.ride.pickupLocation?.lng ?? 0.0,
              ),
              zoom: 18.0,
            ),
            mapType: MapType.hybrid,
            onTap: (argument) async {},
          ),
          Container(
            height: Get.height * 0.18,
            margin: EdgeInsets.only(
              top: Get.height * 0.1,
              left: 20,
              right: 20,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: Get.height * 0.03,
                      color: Colors.red,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PickUp Point",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        widget.ride.pickupLocation?.address != null &&
                                widget.ride.pickupLocation!.address.length > 25
                            ? "${widget.ride.pickupLocation!.address.substring(0, 22)}..."
                            : widget.ride.pickupLocation!.address,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Divider(color: Colors.grey.shade300),
                      Text(
                        "DropOff Point",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        widget.ride.dropoffLocation?.address != null &&
                                widget.ride.dropoffLocation!.address.length > 25
                            ? "${widget.ride.dropoffLocation!.address.substring(0, 22)}..."
                            : widget.ride.dropoffLocation!.address,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (_driverModel.value == null) {
                      return const SizedBox.shrink();
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 2,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            BoxShadow(
                              offset: const Offset(0, -2),
                              blurRadius: 2,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade50,
                        ),
                        width: Get.width,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                widget.ride.driverProfilePicture ?? "",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.ride.driverFirstName} ${widget.ride.driverLastName}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  "Driver",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    _driverModel.value?.car?.model ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  _driverModel.value?.car?.carNumber ?? "",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total fare",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.ride.fare.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Payment Method",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.ride.paymentMethod.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.ride.status ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Payment Status",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.ride.paymentStatus ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  widget.ride.transactionId?.isNotEmpty == true &&
                          widget.ride.transactionId != null
                      ? Row(
                          children: [
                            Text(widget.ride.transactionId.toString()),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: widget.ride.transactionId ?? "",
                                  ),
                                );
                              },
                              child: const Icon(Icons.copy),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 10),
                  widget.ride.scheduleStatus == "pending"
                      ? Obx(
                          () => CommonButton(
                            ontap: () async {
                              if (_userController.isloading.value) {
                                return;
                              }
                              await _userController.cancelScheduleRide(
                                rideId: widget.ride.id ?? '',
                              );
                            },
                            child: _userController.isScheduleLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Cancel Schedule",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
