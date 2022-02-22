import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../index.dart';
import 'index.dart';

class NetRatePage extends GetView<NetRateController> {
  const NetRatePage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext _context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse("https://www.google.com/")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }
}
