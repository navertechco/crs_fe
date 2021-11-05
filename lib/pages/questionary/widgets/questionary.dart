import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'package:naver_crs/pages/questionary/controller.dart';

// ignore: must_be_immutable
class QuestionaryWidget extends GetView<StatelessWidget> {
  QuestionaryWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  final QuestionaryController ctrl;
  double left = kSize.width;
  double top = kSize.height;
  List position = [
    ["A", 18],
    ["B", 22],
    ["C", 26],
    ["D", 30]
  ];
  Rx<List> polls = Rx(getContext('polls'));
  RxInt index = 0.obs;
  Rx<List> pollstosend = Rx([]);
  Rx<List<Widget>> list = Rx(<Widget>[]);
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < polls.value[index.value]['answers'].length; i++) {
      list.value.add(ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          fixedSize: MaterialStateProperty.all<Size>(
              const Size(double.infinity, double.infinity)),
        ),
        child: AnswerWidget(
          answer: Obx(() {
            return Text(polls.value[index.value]['answers'][i]['answer_text']);
          }),
          top: kDefaultPadding * position[i][1],
          left: kDefaultPadding * 2,
          position: position[i][0],
        ),
        onPressed: () {
          // ignore: unrelated_type_equality_checks

          pollstosend.value.add({
            "question_id": Rx(polls.value[index.value]['answers'][i])
                .value['id_question_fk'],
            "answer_id":
                Rx(polls.value[index.value]['answers'][i]).value['id_answer']
          });
          if (index == polls.value.length - 1) {
            ctrl.onSendPoll(context, pollstosend.value);
          } else {
            index++;
          }
        },
      ));
    }

    return Stack(
      children: [
        const Positioned(
          top: kDefaultPadding * 15,
          left: kDefaultPadding * 6,
          child: Text(
            "Opciones Multiples",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const CategoryHeaderWidget(title: "Conocimiento General"),
        QuestionHeaderWidget(
          title: Obx(() {
            return index.value < 10
                ? Text(polls.value[index.value]['question']['question_text'])
                : const Text("");
          }),
        ),
        const Spacer(),
        Positioned(
            top: kDefaultPadding * 17,
            left: kDefaultPadding * 1,
            child: Obx(() {
              return Column(children: list.value);
            })),
      ],
    );
  }
}
