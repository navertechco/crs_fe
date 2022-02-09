// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import '../../../index.dart';
import '../index.dart';
import 'index.dart';

/// hello
class ExperiencesWidget extends HookWidget {
  final ExperiencesController ctrl;
  const ExperiencesWidget({Key? key, required this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    Rx<Widget> left = Rx(CustomLeftOptionsWidget(ctrl: ctrl, counter:counter ));
    useEffect(() {
      print("PARENT LEFT RENDER");
      left.value = CustomLeftOptionsWidget(ctrl: ctrl, counter:counter );
    }, [stream, counter.value]);

    return Stack(children: [
      Obx(() {
        return left.value;
      }),
      CustomRightDayWidget(ctrl: ctrl, counter: counter),
    ]);
  }
}
