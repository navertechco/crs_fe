// ignore_file: file_names
import 'package:flutter/material.dart';

import '../../../index.dart';
import 'index.dart';

class CustomLeftStarDestinationForm extends StatelessWidget {
  const CustomLeftStarDestinationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> destinations = getContext("destinations");
    List<Widget> destinationlist = [];
    for (var key in destinations.keys) {
      destinationlist.add(
        Draggable<String>(
          // Data is the value this Draggable stores.
          data: key,
          feedback: DestinationOptionWidget(destination: key),
          childWhenDragging: DestinationOptionWidget(destination: key),
          child: DestinationOptionWidget(destination: key),
        ),
      );
    }
    return DestinationListWidget(
      children: destinationlist,
    );
  }
}
