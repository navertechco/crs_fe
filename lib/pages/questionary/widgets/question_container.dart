import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/constants.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:naver_trivia/common/index.dart';
import 'package:sweetalert/sweetalert.dart';
import 'question_header.dart';

class QuestionContainerWidget extends StatelessWidget {
  QuestionContainerWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);
  final int endTime = DateTime.now().millisecondsSinceEpoch + 60 * 10000;
  final QuestionHeaderWidget widget;

  @override
  Widget build(BuildContext context) {
    void onEnd() {
      return SweetAlert.show(context,
          title: 'Se acabó el tiempo',
          subtitle: 'Nos vemos en el siguiente torneo',
          style: SweetAlertStyle.success, onPress: (bool isConfirm) {
        Get.toNamed("/Dashboard");
        return false;
      });
    }

    return Stack(
      children: [
        Positioned(
          top: kDefaultPadding * 5,
          left: kDefaultPadding * 2,
          child: Container(
            width: kDefaultPadding * 20,
            height: kDefaultPadding * 9,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                  )
                ]),
            child: Stack(
              children: [
                Positioned(
                  top: kDefaultPadding * 3,
                  left: kDefaultPadding * 2,
                  child: widget.title,
                ),
                Positioned(
                  top: kDefaultPadding * 6,
                  left: kDefaultPadding * 2,
                  child: CountdownTimer(
                    endTime: endTime,
                    onEnd: onEnd,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      setContext('time', time.toString());
                      if (time == null) {
                        return const Text('Se acabó el tiempo!!!');
                      }
                      return Text('Tiempo:  ${time.min ?? 0}:${time.sec} ');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
