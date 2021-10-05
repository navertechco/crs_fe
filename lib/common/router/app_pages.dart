import 'package:get/get.dart';
import 'package:naver_trivia/pages/index.dart'; 
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.kHome,
        page: () => HomePage(),
        transition: Transition.native,
        binding: HomeBinding())
  ];
}
