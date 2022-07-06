// ignore: must_be_immutable
import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DragDestinationWidget extends StatelessWidget {
  String destination;
  String type;
  int index;
  bool out;
  DragDestinationWidget({
    Key? key,
    required this.destination,
    required this.type,
    required this.index,
    this.out = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var explorationDay = getFormValue(
          globalctx.memory["destinations"], index, "explorationDay", "0");
      return globalctx.destinations.contains(destination) &&
              ((!out && type == "tour") || (out && type != "tour"))
          ? Row(
              children: [
                DestinationOptionWidget(
                    destination: destination, type: type, index: index),
                !globalctx.promotedDestinations.contains(index)
                    ? Column(
                        children: [
                          Text(explorationDay.toString(),
                              style: KTextSytle(
                                      context: context,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 204, 164, 61))
                                  .getStyle()),
                          TextButton(
                            onPressed: () {
                              deleteGraphDragDestinationOption(destination);
                            },
                            child: Image.asset("assets/images/1x/redmark.png",
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(explorationDay,
                              style: KTextSytle(
                                      context: context,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 204, 164, 61))
                                  .getStyle()),
                          TextButton(
                            onPressed: () {
                              deleteGraphDragDestinationOption(destination);
                            },
                            child: Image.asset(
                                "assets/images/1x/greencheck.png",
                                width: Get.width * 0.02),
                          ),
                        ],
                      ),
              ],
            )
          : Text('');
    });
  }
}
