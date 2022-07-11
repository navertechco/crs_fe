import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class DestinationDragTargetWidget extends StatelessWidget {
  const DestinationDragTargetWidget({
    Key? key,
    required this.onAccept,
  }) : super(key: key);

  final Null Function(String key) onAccept;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.48,
        child: DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.47,
              width: MediaQuery.of(context).size.width * 0.35,
              color: Color.fromARGB(0, 0, 0, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Obx(() {
                  return SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset("assets/images/1x/dots.png",
                                  color: Colors.grey,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                            ),
                          ],
                        ),
                        Column(children: [
                          ...globalctx.destinationDragData.value,
                        ]),
                      ],
                    ),
                  );
                }),
              ),
            );
          },
          onAccept: onAccept,
        ));
  }
}
