import 'package:get/get.dart';

class ProfileState {
  // title
  final Rx<dynamic> _avatar = Rx("");
  set avatar(value) => _avatar.value = value;
  get avatar => _avatar.value;
}
