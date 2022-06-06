import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:naver_crs/index.dart';

class DGalleryState extends GetXState {
  final title = getContext('session')['username'].toString().obs;
}
