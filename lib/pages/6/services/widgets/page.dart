// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// hello
class ServicesWidget extends HookWidget {
  final ServicesController ctrl; 

  const ServicesWidget({Key? key, required this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
 

    return Stack(children: [
      CustomTopDestinationWidget(
          ctrl: ctrl, counter: counter),
      CustomBodyDestinationsWidget(
          ctrl: ctrl, counter: counter),
    ]);
  }
}
