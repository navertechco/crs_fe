import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class ServiceDragTargetWidget extends StatelessWidget {
  const ServiceDragTargetWidget({
    Key? key,
    required this.onAccept,
  }) : super(key: key);

  final Null Function(String key) onAccept;

  @override
  Widget build(BuildContext context) {
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
              var d = arrivalDate.value;
              return Scrollbar(
                  child: SingleChildScrollView(
                child: Column(children: servicePromotedDragData.value),
              ));
            });
          },
          onAccept: onAccept,
        ));
  }
}
