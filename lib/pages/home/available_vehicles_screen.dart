import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/models/driver_model.dart';
import 'package:rider/models/user_model.dart';
import 'package:rider/resources/car_colors.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/widgets/build_icon_button.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';
import 'package:rider/widgets/loader.dart';

class AvailableVehiclesScreen extends StatefulWidget {
  final LatLng fromLocaton;
  final LatLng toLocaton;
  final String fromLocationName;
  final String toLocationName;
  const AvailableVehiclesScreen({
    super.key,
    required this.fromLocaton,
    required this.toLocaton,
    required this.fromLocationName,
    required this.toLocationName,
  });

  @override
  State<AvailableVehiclesScreen> createState() =>
      _AvailableVehiclesScreenState();
}

class _AvailableVehiclesScreenState extends State<AvailableVehiclesScreen> {
  final _userController = Get.find<UserController>();

  final _radiusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userController.getNearByDrivers(
      fromLocation: widget.fromLocaton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Available vehicles",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          buildIconButton(
            icon: Icons.filter_list_rounded,
            onTap: () {},
            shape: BoxShape.circle,
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 7),
        ],
      ),
      body: Obx(() {
        if (_userController.isloading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (_userController.availableDriverList.isEmpty) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: Get.height * 0.5,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No available vehicles found.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    textController: _radiusController,
                    textInputType: TextInputType.number,
                    hintText: "Default Radius 2100, Increase the radius",
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width / 1.5,
                    child: CommonButton(
                      child: const Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ontap: () async {
                        if (_radiusController.text.isEmpty) {
                          return;
                        }
                        await _userController.getNearByDrivers(
                          fromLocation: widget.fromLocaton,
                          radius: int.parse(_radiusController.text),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: _userController.availableDriverList.length,
            itemBuilder: (context, index) {
              DriverModel driverModel =
                  _userController.availableDriverList[index];
              return InkWell(
                onTap: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return EachCarDetails(
                        fromLocaton: widget.fromLocaton,
                        toLocaton: widget.toLocaton,
                        driverModel: driverModel,
                        driverUserId: driverModel.userId ?? "",
                        fromLocationName: widget.fromLocationName,
                        toLocationName: widget.toLocationName,
                      );
                    },
                  );
                },
                child: CarCards(
                  driverModel: driverModel,
                ),
              );
            },
          );
        }
      }),
    );
  }
}

class CarCards extends StatelessWidget {
  final DriverModel driverModel;
  const CarCards({
    super.key,
    required this.driverModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/image10.png",
                width: 100,
                height: 72,
                color: getCarColor(driverModel.car?.color ?? ""),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driverModel.car?.model ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    driverModel.car?.carNumber ?? "",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      Text(
                        driverModel.reviews?.averageRating.toString() ?? "",
                      ),
                      // Icon(Icons.star, color: Colors.yellow),
                      // Icon(Icons.star, color: Colors.yellow),
                      // Icon(Icons.star, color: Colors.yellow),
                      // Icon(Icons.star, color: Colors.yellow),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text(
                "${driverModel.car?.capacity} - Seater",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                driverModel.car?.yearOfManufacture.toString() ?? "",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class EachCarDetails extends StatefulWidget {
  final String driverUserId;
  final DriverModel driverModel;
  final LatLng fromLocaton;
  final LatLng toLocaton;
  final String fromLocationName;
  final String toLocationName;
  const EachCarDetails({
    super.key,
    required this.driverUserId,
    required this.driverModel,
    required this.fromLocaton,
    required this.toLocaton,
    required this.fromLocationName,
    required this.toLocationName,
  });

  @override
  State<EachCarDetails> createState() => _EachCarDetailsState();
}

class _EachCarDetailsState extends State<EachCarDetails> {
  final Rxn<UserModel> _userModel = Rxn<UserModel>();
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserWithId();
    });
  }

  void getUserWithId() async {
    _userModel.value = await _userController.getUserById(
      userId: widget.driverUserId,
    );
  }

  final RxString _paymentMethod = "".obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Obx(
        () => _userController.isGetUserIdLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      "assets/images/image10.png",
                      width: 200,
                      color: getCarColor(widget.driverModel.car?.color ?? "") ??
                          null,
                    ),
                  ),
                  const Text(
                    "Car",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.driverModel.car?.model ?? "",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "${widget.driverModel.car?.capacity} Seats",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        widget.driverModel.car?.carNumber ?? "",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    "Driver",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _userModel.value?.profilePicture !=
                                    null &&
                                _userModel.value!.profilePicture!.isNotEmpty
                            ? NetworkImage(_userModel.value!.profilePicture!)
                            : null,
                        child: _userModel.value?.profilePicture == null ||
                                _userModel.value!.profilePicture!.isEmpty
                            ? Icon(Icons.person,
                                size: 30, color: Colors.grey[600])
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_userModel.value?.firstName} ${_userModel.value?.lastName}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _userModel.value?.status ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.yellow, size: 15),
                              Text(widget.driverModel.reviews?.averageRating
                                      .toString() ??
                                  ""),
                              // Icon(Icons.star, color: Colors.yellow, size: 15),
                              // Icon(Icons.star, color: Colors.yellow, size: 15),
                              // Icon(Icons.star, color: Colors.yellow, size: 15),
                              // Icon(Icons.star, color: Colors.yellow, size: 15),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => CommonButton(
                      child: _userController.isRequestRideLoading.value
                          ? const CarLoader()
                          : const Text(
                              "Select Vehicle",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                      ontap: () async {
                        if (_paymentMethod.isEmpty) {
                          displayDialogBoxPaymentMethod(context);
                        } else {
                          print(widget.driverModel.id);
                          await _userController.requestRide(
                            driverId: widget.driverModel.id!,
                            fromLocation: widget.fromLocaton,
                            fromLocationName: widget.fromLocationName,
                            toLocation: widget.toLocaton,
                            toLocationName: widget.toLocationName,
                            paymentMethod: _paymentMethod.value,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<dynamic> displayDialogBoxPaymentMethod(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            CommonButton(
              ontap: () {
                _paymentMethod.value = "cash";
                Navigator.pop(context);
              },
              child: const Text(
                "Cash",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            CommonButton(
              bgColor: Colors.transparent,
              border: Border.all(
                width: 2,
                color: AppColors.primaryColor,
              ),
              ontap: () {
                _paymentMethod.value = "stripe";
                Navigator.pop(context);
              },
              child: const Text(
                "Stripe",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Payment Method",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text("Select payment method to use after the trip is completed"),
            ],
          ),
        );
      },
    );
  }
}
