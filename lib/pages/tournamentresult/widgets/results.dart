import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; 
import 'package:naver_trivia/common/index.dart';

import 'package:naver_trivia/common/widgets/index.dart';

import '../index.dart';
import 'index.dart';

/// hello
// ignore: must_be_immutable
class TournamentResultWidget extends GetView<TournamentResultController> {
  const TournamentResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var answers = getContext('answers'); 
    var polls = getContext('polls');
    var index = 0;
    List<Widget> list = [];
    for (var answer in answers) {
      var poll = polls[index];
      var detail = poll['answers']
          .toList()
          .where((j) => j['id_answer'] == answer['answer_id'])
          .toList()[0]['answer_text'];
      list.add(Column(children: [
        SizedBox(height: Get.height * 0.02),
        ResultItemWidget(
            title: Text("Pregunta " + (index + 1).toString() + ": ",
                style: TextStyle(
                    fontSize: Get.height * 0.02, fontWeight: FontWeight.bold)),
            detail: Text(
              detail,
              style: TextStyle(
                fontSize: Get.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            )),
      ]));
      index++;
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.02),
          Positioned(
            top: Get.height * 0.04,
            left: Get.width * 0.28,
            child: RadiantGradientMask(
              colors: GradientColors.flyHigh,
              child: SquareOptionWidget(
                  borderRadius: 8.0,
                  padding: 30,
                  child: SvgPicture.asset(
                      "assets/custom/svg/icons/TrophyIcon.svg"),
                  url: "/Ranking"),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          ResultItemWidget(
              title: const Text('Total de preguntas contestadas: '),
              detail: Text(
                answers.length.toString(),
                style: TextStyle(
                  fontSize: Get.height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              )),
          SizedBox(height: Get.height * 0.02),
          ResultItemWidget(
              title: const Text('Total de tiempo en torneo: '),
              detail: Text(
                getContext('timeelapsed').toString(),
                style: TextStyle(
                  fontSize: Get.height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Column(
            children: list,
          )
        ],
      ),
    );
  }
}
