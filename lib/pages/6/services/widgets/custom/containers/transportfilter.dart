import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/6/services/widgets/custom/containers/leftHeader.dart';
import '../../../controller.dart';

// ignore: must_be_immutable
class TransportFilter extends HookWidget {
  TransportFilter(
      {Key? key, required this.ctrl, this.counter, required this.formKey})
      : super(key: key);
  GlobalKey<FormState> formKey;
  final ServicesController ctrl;
  final counter;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0,
        left: MediaQuery.of(context).size.width * 0.6,
      ),
      child: BodyWidget(ctrl: ctrl, counter: counter, formKey: formKey),
    );
  }
}

class BodyWidget extends StatelessWidget {
  BodyWidget({Key? key, this.ctrl, this.counter, required this.formKey})
      : super(key: key);
  final ctrl;
  final counter;
  GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var t = arrivalDate.value;
      return Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.08,
          ),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  LeftHeader(ctrl: ctrl, counter: counter),
                  SingleChildScrollView(
                    child: Column(
                      children: [],
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }
}
