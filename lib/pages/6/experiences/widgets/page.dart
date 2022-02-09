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
  ExperiencesWidget({Key? key, required this.ctrl}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    useEffect(() {
      print("PARENT LEFT RENDER");
    }, [stream, counter.value]);

    return Form(
      key: formKey,
      child: Stack(children: [
        CustomLeftOptionsWidget(ctrl: ctrl, counter: counter),
        CustomRightDayWidget(ctrl: ctrl, counter: counter),
      ]),
    );
  }
}
