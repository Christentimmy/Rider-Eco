import 'package:rider/resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideDetailsScreen extends StatelessWidget {
  const RideDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildRideHeader(),
            const SizedBox(height: 20),
            TableWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildRideHeader() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Balance:  ",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "\$60.00",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Refund:  ",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "\$60.00",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Bonuses:  ",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "\$60.00",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Ride Details",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  const TableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Colors.grey.withOpacity(0.3),
        width: 2,
      ),
      columnWidths: const {
        0: FractionColumnWidth(0.4),
        1: FractionColumnWidth(0.6),
      },
      children: [
        // Header row
        TableRow(
          decoration: BoxDecoration(color: AppColors.primaryColor),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Order Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'The Payment for completed Request',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),

        // Row 1
        TableRow(
          decoration: BoxDecoration(color: Color(0xffEDEDED)),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Express',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Min 2 Soles with 10% Commission to company',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),

        // Row 2
        TableRow(
          decoration: BoxDecoration(color: Color(0xffEDEDED)),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Flete',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Min 2 Soles plus 1 sole extra charge with 10% Commission to company',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
