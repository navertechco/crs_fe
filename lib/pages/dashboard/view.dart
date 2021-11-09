import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'index.dart';

class DashboardPage extends GetView<DashboardController> {
  DashboardPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return const ProfileLayoutWidget(
        child: DashboardWidget(), text: "Dashboard");
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var session = getContext('session');
    String name = session['surname'] + " " + session['lastname'];
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            key: _key,
            endDrawer: MenuWidget(),
            body: Stack(
              children: [
                _buildView(context),
                Padding(
                    padding: EdgeInsets.only(top: 55.0, left: Get.width * 0.1),
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 45.0, left: Get.width * 0.85),
                  child: IconButton(
                    icon: ClipRRect(
                      child: Image.memory(base64Decode(session['avatar'])),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    onPressed: () => _key.currentState!.openEndDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const BottonNavWidget()));
  }
}
