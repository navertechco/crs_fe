import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

class ScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  try {
    HttpOverrides.global = MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    var pages = AppPages.pages;
    PRegistry registry =
        routes.toList().firstWhere((element) => element.name == "/NetRate");

    runApp(GetMaterialApp(
        scrollBehavior: ScrollBehavior(),
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
