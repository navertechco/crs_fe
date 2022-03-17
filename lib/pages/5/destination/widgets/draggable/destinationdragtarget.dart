import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../index.dart';
import '../index.dart';

class DestinationDragTargetWidget extends StatelessWidget {
  const DestinationDragTargetWidget({
    Key? key,
    required this.onAccept,
  }) : super(key: key);

  final Null Function(String key) onAccept;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.46,
        child: DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
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
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset("assets/custom/img/dots.png",
                                  color: Colors.grey,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                            ),
                          ],
                        ),
                        Column(children: [
                          ...globalctx.destinationDragData.value,
                        ]),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.0,
                            top: MediaQuery.of(context).size.height * 0.5,
                          ),
                          child: DragDestinationWidget(
                              destination: departure["description"],
                              index:
                                  globalctx.destinationDragData.value.length -
                                      1,
                              type: "departure",
                              out: true),
                        )
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
