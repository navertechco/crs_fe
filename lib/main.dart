import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart'; 

class ScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices;
}

void main() {
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  var pages = AppPages.pages;
  PRegistry registry =
      routes.toList().firstWhere((element) => element.name == "/Splash");
  
  runApp(GetMaterialApp(
      scrollBehavior: ScrollBehavior(),
      debugShowCheckedModeBanner: false,
      initialRoute: registry.name,
      theme: lightTheme,
      darkTheme: darkTheme,
      defaultTransition: registry.transition,
      initialBinding: registry.binding,
      getPages: pages.toList()));
}
