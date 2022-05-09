import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class ServiceDragTargetWidget extends StatelessWidget {
  const ServiceDragTargetWidget({
    Key? key,
    required this.onAccept,
  }) : super(key: key);

  final Null Function(String key) onAccept;

  @override
  Widget build(BuildContext context) {
    // if (globalctx.servicePromotedDragData.value.isEmpty) {
    // for (var i = 0; i < destDays.value; i++) {
    //   globalctx.servicePromotedDragData.value[i] = <Widget>[];
    //   //   }
    //   // }

    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.75,
        child: DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Obx(() {
              return Scrollbar(
                  child: SingleChildScrollView(
                child: Column(
                    children: globalctx
                            .servicePromotedDragData.value[currentDay.value] ??
                        []),
              ));
            });
          },
          onAccept: onAccept,
        ));
  }
}
