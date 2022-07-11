import 'package:get/get.dart';
import 'package:naver_crs/index.dart';

class DGalleryState extends GetXState {
  final title = getContext('session')['username'].toString().obs;
}
