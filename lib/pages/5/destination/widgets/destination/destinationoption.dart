import 'package:flutter/material.dart';
import '../index.dart';

class DestinationOptionWidget extends StatelessWidget {
  const DestinationOptionWidget(
      {Key? key,
      required this.destination,
      this.type = "tour",
      this.index = 0,
      this.isListed = false})
      : super(key: key);
  final String destination;
  final String type;
  final int index;
  final bool isListed;
  @override
  Widget build(BuildContext context) {
    return GoldBorderWidget(
        child: SwitcherWidget(
            destination: destination,
            type: type,
            index: index,
            isListed: isListed,
            firstchild: DestinationFrontOptionWidget(
              destination: destination,
              index: index,
              type: type,
              isListed: isListed,
            ),
            seccondchild:
                DestinationRearOptionWidget(destination: destination)));
  }
}
