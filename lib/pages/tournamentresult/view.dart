import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class TournamentResultPage extends GetView<TournamentResultController> {
  const TournamentResultPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ResultsLayoutWidget(
        child: TournamentResultWidget(), text: "Resultado Actual");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: _buildView(context),
        ));
  }
}
