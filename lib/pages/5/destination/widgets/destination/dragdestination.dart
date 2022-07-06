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
      return globalctx.destinations.contains(destination) &&
              ((!out && type == "tour") || (out && type != "tour"))
          ? Row(
              children: [
                DestinationOptionWidget(
                    destination: destination, type: type, index: index),
                DestinationIndicator(
                    destination: destination, type: type, index: index),
              ],
            )
          : Text('');
    });
  }
}

class DestinationIndicator extends StatelessWidget {
  const DestinationIndicator({
    Key? key,
    required this.destination,
    required this.index,
    required this.type,
  }) : super(key: key);
  final destination;
  final index;
  final type;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var explorationDay = getFormValue(
          globalctx.memory["destinations"], index, "explorationDay", "0");
      return Column(
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
            child: Image.asset(
                !globalctx.promotedDestinations.contains(index)
                    ? "assets/images/1x/redmark.png"
                    : "assets/images/1x/greencheck.png",
                width: MediaQuery.of(context).size.width * 0.02),
          ),
        ],
      );
    });
  }
}
