import 'package:get/get.dart';
import 'package:main/pages/home/home_binding.dart';
import 'package:main/pages/home/home_view.dart';
part './app_routes.dart';

abstract class AppPages {

  static final pages = [
    GetPage(
      name: Routes.HOME, 
      page:()=> HomePage(),
      transition: Transition.native,
      binding: HomeBinding()
      )
  ];
}