import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rider/controller/socket_controller.dart';
import 'package:rider/controller/storage_controller.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/pages/auth/signup_screen.dart';
import 'package:rider/pages/home/balance_history_screen.dart';
import 'package:rider/pages/home/payment_method_screen.dart';
import 'package:rider/pages/home/profile_screen.dart';
import 'package:rider/pages/home/schedule_screen.dart';
import 'package:rider/pages/home/settings_screen.dart';
import 'package:rider/pages/home/soure_destination_screen.dart';
import 'package:rider/pages/home/support_screen.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/service/location_service.dart';
import 'package:rider/widgets/build_icon_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final RxList<Map<String, dynamic>> _places = <Map<String, dynamic>>[].obs;
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    saveUserOneSignalId();
  }

  void saveUserOneSignalId() async {
    String? playerId = await OneSignal.User.getOnesignalId();
    if (playerId != null) {
      await _userController.saveUserOneSignalId(oneSignalId: playerId);
    }
  }

  void searchPlaces(String query) async {
    List<Map<String, dynamic>> results =
        await LocationService.searchPlaces(query);
    _places.value = results;
  }

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(59.9139, 10.7522),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildSideBar(),
      body: Stack(
        children: [
          SizedBox(
            height: Get.height * 0.65,
            width: Get.width,
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              mapType: MapType.hybrid,
              onTap: (argument) async {},
            ),
          ),
          Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 50,
                ),
                child: buildIconButton(
                  icon: Icons.menu,
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            },
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
        height: Get.height * 0.389,
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
            Text(
              "Good Morning, John",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              "Where are you going today?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "Search destination",
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
              textController: _searchController,
              onChanged: searchPlaces,
              bgColor: Colors.white.withOpacity(0.3),
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _places.length,
                  itemBuilder: (context, index) {
                    return _buildListTile(
                      title: _places[index]["name"],
                      onTap: () {
                        String destination = _places[index]["name"];
                        String lat = _places[index]["lat"];
                        String lng = _places[index]["lon"];
                        print("Selected Place: $lat $lng");
                        Get.to(
                          () => SoureDestinationScreen(
                            destination: destination,
                            destinationLatLng:
                                LatLng(double.parse(lat), double.parse(lng)),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minTileHeight: 45,
      leading: Container(
        height: 45,
        width: 45,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xff6CF102),
              Color(0xff3E8B01),
            ],
          ),
        ),
        child: const Icon(
          Icons.location_on,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

Drawer buildSideBar() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 19, 19, 19),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/avater2.png",
                width: 60,
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Jonathon Smith",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        "4.8 (5000)",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text(
            'Home Screen',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Get.to(() => HomeScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Get.to(() => const ProfileScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text(
            'Balance & History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Get.to(() => BalanceAndHistoryScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month),
          title: const Text(
            'Schedule',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Get.to(() => ScheduleScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.credit_card),
          title: const Text(
            'Payments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Get.to(() => PaymentMethodScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Get.to(() => SettingScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.support_agent),
          title: const Text(
            'Support',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Get.to(() => SupportScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.contact_support_rounded),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () async {
            final storageController = Get.find<StorageController>();
            await storageController.deleteToken();
            final socketService = Get.find<SocketController>();
            socketService.disconnectSocket();
            Get.offAll(() => SignUpScreen());
          },
        ),
      ],
    ),
  );
}
