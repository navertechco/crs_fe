import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';

// ignore: must_be_immutable
class NavBarWidget extends StatelessWidget {
  const NavBarWidget({Key? key}) : super(key: key);

  void _onItemTapped(int index) async {
    try {
      selectedIndex.value = index;
      Get.toNamed("/${pageList[index]["label"]}");
    } catch (e) {
      await logOut(session["username"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Obx(() {
        List<BottomNavigationBarItem> itemList = [];
        for (var page in pageList) {
          if (!isFirstLaunch) {
            page["key"] = GlobalKey();
          }

          itemList.add(BottomNavigationBarItem(
            icon: Icon(page["icon"], key: page["key"], color: page["color"]),
            label: page["label"],
          ));
        }
        itemList.add(BottomNavigationBarItem(
          icon: Icon(Icons.exit_to_app, color: Colors.red),
          label: "Exit",
        ));

        return BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.black,
          iconSize: 20,
          showUnselectedLabels: true,
          items: itemList,
          currentIndex:
              selectedIndex.value >= pageList.length ? 0 : selectedIndex.value,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        );
      });
    } catch (e) {
      return Container();
    }
  }
}
