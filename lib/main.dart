import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/router/app_pages.dart';
import 'common/themes/index.dart';
import 'package:flutter/services.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  var pages = AppPages.pages;
  PRegistry registry =
      routes.toList().firstWhere((element) => element.name == "/DGallery");

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: registry.name,
      theme: lightTheme,
      darkTheme: darkTheme,
      defaultTransition: registry.transition,
      initialBinding: registry.binding,
      getPages: pages.toList()));
}
