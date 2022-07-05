// @dart=2.9
import 'dart:io';
import 'common/behavior.dart' as common_behavior;
import 'package:flutter/material.dart';
import '../index.dart'; 
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  try {
    HttpOverrides.global = common_behavior.MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    var pages = AppPages.pages;
    PRegistry registry =
        routes.toList().firstWhere((element) => element.name == "/Splash");

    runApp(GetMaterialApp(
        scrollBehavior: common_behavior.ScrollBehavior(),
        debugShowCheckedModeBanner: false,
        initialRoute: registry.name,
        theme: lightTheme,
        darkTheme: darkTheme,
        defaultTransition: registry.transition,
        initialBinding: registry.binding,
        getPages: pages.toList()));
  } catch (e) {
    log(e);
  }
}
