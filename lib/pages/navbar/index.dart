import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index.dart';

// ignore: must_be_immutable
class NavBarWidget extends StatelessWidget {
  NavBarWidget({Key? key}) : super(key: key);
  List pageList = [
    "Tour",
    "Customer",
    "Logistic",
    "Destination",
    "Experiences"
  ];
  List<BottomNavigationBarItem> itemList = [];
  void _onItemTapped(int index) {
    selectedIndex.value = index;
    Get.toNamed("/${pageList[index]}");
  }

  @override
  Widget build(BuildContext context) {
    for (var page in pageList) {
      itemList.add(BottomNavigationBarItem(
        icon: Icon(Icons.pages),
        label: page,
      ));
    }
    return Obx(() {
      return BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.black,
        iconSize: 20,
        showUnselectedLabels: true,
        items: itemList,
        currentIndex: selectedIndex.value,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      );
    });
  }
}
