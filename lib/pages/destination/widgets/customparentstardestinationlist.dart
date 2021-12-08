// ignore_file: file_names
import 'package:flutter/material.dart';

import 'index.dart';

class CustomParentStarDestinationListForm extends StatelessWidget {
  const CustomParentStarDestinationListForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DestinationListWidget(
      children: [
        DestinationOptionWidget(
            child: RearOptionWidget(destination: "northern")),
        DestinationOptionWidget(
            child: RearOptionWidget(destination: "southern")),
        DestinationOptionWidget(
            child: RearOptionWidget(destination: "galapagos")),
        DestinationOptionWidget(
            child: RearOptionWidget(destination: "volcano")),
        DestinationOptionWidget(child: RearOptionWidget(destination: "amazon")),
        DestinationOptionWidget(child: RearOptionWidget(destination: "quito")),
        DestinationOptionWidget(
            child: RearOptionWidget(destination: "guayaquil")),
        DestinationOptionWidget(child: RearOptionWidget(destination: "cuenca")),
        DestinationOptionWidget(
            child: RearOptionWidget(destination: "otavalo")),
        DestinationOptionWidget(child: RearOptionWidget(destination: "coast")),
      ],
    );
  }
}
