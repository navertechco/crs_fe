import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:naver_trivia/pages/home/bindings.dart'; 

import 'common/router/app_pages.dart';
import 'common/theme/theme_light.dart'; 


void main() {
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.kHome,
      theme: appThemeData,
      defaultTransition: Transition.fadeIn,
      initialBinding: HomeBinding(),
      getPages: AppPages.pages));
}

