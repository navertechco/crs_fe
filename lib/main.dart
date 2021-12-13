import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/router/app_pages.dart';
import 'common/themes/index.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

void main() {
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  var pages = AppPages.pages;
  PRegistry registry = routes
      .toList()
      .firstWhere((element) => element.name == "/DGallery");

  runApp(GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      initialRoute: registry.name,
      theme: lightTheme,
      darkTheme: darkTheme,
      defaultTransition: registry.transition,
      initialBinding: registry.binding,
      getPages: pages.toList()));
}
