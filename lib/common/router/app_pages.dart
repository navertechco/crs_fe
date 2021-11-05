import 'package:get/get.dart';
import 'package:naver_trivia/pages/index.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = routes.map((i) =>
      GetPage(name: i.name, page: i.page, transition: i.transition, binding: i.binding));
}
