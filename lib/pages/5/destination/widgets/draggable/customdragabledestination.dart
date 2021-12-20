import 'package:flutter/material.dart';

import '../index.dart';

class CustomDragableDestination extends StatelessWidget {
  const CustomDragableDestination({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final String destination;

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      // Data is the value this Draggable stores.
      data: destination,
      feedback: DestinationOptionWidget(destination: destination),
      childWhenDragging: DestinationOptionWidget(destination: destination),
      child: DestinationOptionWidget(destination: destination),
    );
  }
}
