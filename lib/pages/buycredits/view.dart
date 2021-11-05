import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/index.dart';
import 'package:naver_trivia/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class BuyCreditsPage extends GetView<BuyCreditsController> {
  const BuyCreditsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
      body: _buildBuyCreditsFormPage(context),
    ));
  }
}

GetBuilder<BuyCreditsController> _buildBuyCreditsFormPage(
  BuildContext context,
) {
  return GetBuilder<BuyCreditsController>(
    id: 'signup_form_page',
    builder: (controller) => ContentLayoutWidget(
        child: BuyCreditsFormPage(ctrl: controller), text: "Comprar Créditos"),
  );
}
