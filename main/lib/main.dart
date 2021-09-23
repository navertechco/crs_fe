import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main/common/router/app_pages.dart';
import 'package:main/pages/home/home_binding.dart';

import 'common/theme/theme_light.dart';

void main() {
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      theme: appThemeData,
      defaultTransition: Transition.fadeIn,
      initialBinding: HomeBinding(),
      getPages: AppPages.pages));
}
