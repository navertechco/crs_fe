// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';

/// hello
class ExperiencesWidget extends HookWidget {
  final ExperiencesController ctrl;
  final formKey = GlobalKey<FormState>();

  ExperiencesWidget({Key? key, required this.ctrl}) : super(key: key);

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
