// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'index.dart';

// ignore: must_be_immutable
class DestinationsOrderableListWidget extends StatelessWidget {
  const DestinationsOrderableListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Null Function(String key) onAccept;

    onAccept = (String key) {
      moveDestinationFunction(key, context);
    };
    return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.16,
          left: MediaQuery.of(context).size.width * 0.46,
        ),
        child: DestinationDragTargetWidget(onAccept: onAccept));
  }
}
