import 'package:get/get.dart';
import 'package:main/pages/home/home_repository.dart';

class HomeController extends GetxController {

final HomeRepository repository;
HomeController(this.repository);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}