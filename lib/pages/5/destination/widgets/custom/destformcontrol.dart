import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';
import '../index.dart';

class DestFormmControlsWidget extends StatelessWidget {
  const DestFormmControlsWidget({
    Key? key,
    required this.explorationDay,
    required this.destination,
    required this.index,
    required this.type,
    required this.explorationMode,
    required this.keyActivities,
  }) : super(key: key);

  final Rx<int> explorationDay;
  final String destination;
  final index;
  final type;
  final RxString explorationMode;
  final List<String> keyActivities;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      child: SizedBox(
        child: Wrap(children: [
          BusinessExpDayWidget(
              explorationDay: explorationDay,
              destination: destination,
              index: index,
              type: type),
          BusinessHotelWidget(index: index),
          BusinessArrivalWidget(
            explorationMode: explorationMode,
            type: type,
            destination: destination,
            index: index,
          ),
          BusinessTrWidget(
              explorationMode: explorationMode,
              index: index,
              type: type,
              destination: destination),
          BusinessKAWidget(
              explorationMode: explorationMode,
              keyActivities: keyActivities,
              index: index),
          BuisnessExpmodeWidget(
              destination: destination,
              explorationDay: explorationDay,
              explorationMode: explorationMode,
              index: index),
          BusinessRouteWidget(
              explorationDay: explorationDay,
              destination: destination,
              explorationMode: explorationMode),
          BusinessIHWidget(
              explorationMode: explorationMode,
              destination: destination,
              index: index),
        ]),
      ),
    );
  }
}
