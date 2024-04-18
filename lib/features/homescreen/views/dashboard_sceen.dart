import 'package:bidder/features/homescreen/controller/home_controller.dart';
import 'package:bidder/features/homescreen/widgets/sku_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.fetchingData.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      }
      if (controller.bidDetails!.isEmpty) {
        return const Center(
          child: Text("Network Error"),
        );
      }
      return ListView.builder(
          itemCount: controller.bidDetails?.length,
          itemBuilder: (BuildContext context, int index) {
            return SKUCard(
              bid: controller.bidDetails![index],
              homeController: controller,
            );
          });
    });
  }
}
