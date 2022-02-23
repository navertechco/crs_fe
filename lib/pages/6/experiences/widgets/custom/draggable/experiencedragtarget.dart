import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class ExperienceDragTargetWidget extends StatelessWidget {
  const ExperienceDragTargetWidget({
    Key? key,
    required this.onAccept,
  }) : super(key: key);

  final Null Function(String key) onAccept;

  @override
  Widget build(BuildContext context) {
    if (globalctx.experienceDragData.value.isEmpty) {
      for (var i = 0; i < destDays.value; i++) {
        globalctx.experienceDragData.value[i] = <Widget>[];
      }
    }

    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.44,
        child: DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              color: Colors.grey[50],
              child: Obx(() {
                return SingleChildScrollView(
                  child: Column(
                      children: globalctx
                              .experienceDragData.value[currentDay.value] ??
                          []),
                );
              }),
            );
          },
          onAccept: onAccept,
        ));
  }
}
