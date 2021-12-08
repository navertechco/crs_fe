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
        DestinationOptionWidget(destination: "northern"),
        DestinationOptionWidget(destination: "southern"),
        DestinationOptionWidget(destination: "galapagos"),
        DestinationOptionWidget(destination: "volcano"),
        DestinationOptionWidget(destination: "amazon"),
        DestinationOptionWidget(destination: "quito"),
        DestinationOptionWidget(destination: "guayaquil"),
        DestinationOptionWidget(destination: "cuenca"),
        DestinationOptionWidget(destination: "otavalo"),
        DestinationOptionWidget(destination: "coast"),
      ],
    );
  }
}
