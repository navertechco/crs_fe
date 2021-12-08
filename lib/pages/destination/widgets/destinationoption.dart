import 'package:flutter/material.dart';
import 'package:naver_crs/common/index.dart';
import 'index.dart';

class DestinationOptionWidget extends StatelessWidget {
  const DestinationOptionWidget({Key? key, required this.child})
      : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GoldBorderWidget(child:child);
  }
}


