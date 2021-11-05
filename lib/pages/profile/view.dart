import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/common/widgets/index.dart';
import '../index.dart';
import 'index.dart';
import 'widgets/index.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(child: ProfileWidget(), text: "Perfil");
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var session = getContext('session');

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            key: _key,
            endDrawer: MenuWidget(),
            body: Stack(
              children: [
                _buildView(context),
                Padding(
                  padding: EdgeInsets.only(top: 45.0, left: Get.width * 0.85),
                  child: IconButton(
                    icon: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          Image.memory(base64Decode(session['avatar'])).image,
                    ),
                    onPressed: () => _key.currentState!.openEndDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],
            )));
  }
}
