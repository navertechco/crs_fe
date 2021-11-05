import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/widgets/index.dart';
import 'index.dart';
import 'widgets/index.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        child: SettingsFormWidget(), text: "Configuración");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
      body: _buildView(context),
    ));
  }
}
