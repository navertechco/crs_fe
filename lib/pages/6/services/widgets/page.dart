// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../index.dart';
import '../index.dart';
import 'index.dart';

/// hello
class ServicesWidget extends HookWidget {
  final ServicesController ctrl;
  final formKey = GlobalKey<FormState>();

  ServicesWidget({Key? key, required this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    useEffect(() {}, [stream, counter.value]);

    return Stack(children: [
      CustomTopDayWidget(ctrl: ctrl, counter: counter, formKey: formKey),
      CustomBodyDaysWidget(ctrl: ctrl, counter: counter, formKey: formKey),
    ]);
  }
}
