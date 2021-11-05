import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/pages/buycredits/controller.dart';
import 'package:naver_crs/pages/buycredits/widgets/index.dart';

class BuyCreditsFormPage extends GetView<StatelessWidget> {
  BuyCreditsFormPage({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final BuyCreditsController ctrl;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: BuyCreditsFormWidget(
              formKey: _formKey, state: ctrl.state, ctrl: ctrl),
        ),
      ),
    );
  }
}
