import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rider/controller/user_controller.dart';
import 'package:rider/resources/color_resources.dart';
import 'package:rider/utils/date_converter.dart';
import 'package:rider/widgets/custom_button.dart';
import 'package:rider/widgets/custom_textfield.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_userController.isPaymentHistoryFetched.value) {
        _userController.getUserPaymentHistory();
      }
      _userController.scrollController.addListener(() {
        if (_userController.scrollController.position.pixels >=
            _userController.scrollController.position.maxScrollExtent - 100) {
          _userController.loadMorePayments();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (_userController.isloading.value) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (_userController.userPaymentList.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text("Empty"),
                    ),
                  );
                }
                return Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E5EC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return FilterHistory();
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat("MMM").format(DateTime.now()),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(color: Colors.grey),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            controller: _userController.scrollController,
                            itemCount:
                                _userController.userPaymentList.length + 1,
                            itemBuilder: (context, index) {
                              if (index ==
                                  _userController.userPaymentList.length) {
                                return _userController.isFetchingMore.value
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }
                              final payment =
                                  _userController.userPaymentList[index];
                              return ListTile(
                                horizontalTitleGap: 5.0,
                                minTileHeight: 90,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      const Color.fromARGB(255, 245, 245, 245),
                                  child: Icon(
                                    payment.status == "pending"
                                        ? Icons.hourglass_top_sharp
                                        : payment.status == "failed"
                                            ? Icons.cancel
                                            : Icons.arrow_upward,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      "Transfer to ${payment.ride.driverFirstName}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Kr${payment.amount.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          convertDateToNormal(
                                            payment.processedAt.toString(),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const Spacer(),
                                        RichText(
                                          text: TextSpan(
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                            children: [
                                              const TextSpan(text: "status: "),
                                              TextSpan(
                                                text: payment.status,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: payment.status ==
                                                          "successful"
                                                      ? Colors.green
                                                      : payment.status ==
                                                              "failed"
                                                          ? Colors.red
                                                          : Colors.grey,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${payment.transactionId.toString().substring(0, 5)}...",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(
                                              ClipboardData(
                                                text: payment.transactionId,
                                              ),
                                            );
                                          },
                                          child: const Icon(Icons.copy),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        "Payment History",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.menu),
          );
        },
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String status) {
            if (status == "all") {
              _userController.getUserPaymentHistory();
              return;
            }
            _userController.getUserPaymentHistory(status: status);
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(value: "all", child: Text("All")),
            const PopupMenuItem(value: "pending", child: Text("Pending")),
            const PopupMenuItem(value: "successful", child: Text("Successful")),
            const PopupMenuItem(value: "failed", child: Text("Failed")),
          ],
          icon: const Icon(Icons.filter_alt_outlined),
        ),
      ],
    );
  }
}

class FilterHistory extends StatelessWidget {
  FilterHistory({super.key});

  final _userController = Get.find<UserController>();
  final Rxn<DateTime> _startDate = Rxn<DateTime>();
  final Rxn<DateTime> _endDate = Rxn<DateTime>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const Text("Month"),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          const Text("Start Date"),
          Obx(
            () => CustomTextField(
              hintText: DateFormat("MMM dd yyyy").format(
                _startDate.value ?? DateTime.now(),
              ),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.parse(
                    _userController.userModel.value?.createdAt.toString() ?? "",
                  ),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  _startDate.value = date;
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text("End Date"),
          Obx(
            () => CustomTextField(
              hintText: DateFormat("MMM dd yyyy").format(
                _endDate.value ?? DateTime.now(),
              ),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.parse(
                    _userController.userModel.value?.createdAt.toString() ?? "",
                  ),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  _endDate.value = date;
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          CommonButton(
            ontap: () async {
              _userController.getUserPaymentHistory(
                startDate: _startDate.value.toString(),
                endDate: _endDate.value.toString(),
              );
              Navigator.pop(context);
            },
            child: const Text(
              "Confirm",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
