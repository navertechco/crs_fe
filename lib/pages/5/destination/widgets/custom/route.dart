
import 'package:flutter/material.dart';

import '../../../../../index.dart';

class RouteWidget extends StatelessWidget {
  const RouteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomTitleWidget(
            width: 0.225,
            fontWeight: FontWeight.bold,
            label: "Routes Information"),
        RoundedFormButton(
          color: Colors.grey,
          label: "Select",
          height: 0.05,
          fontSize: 3,
          fontWeight: FontWeight.bold,
          textColor: Colors.black,
          onPressed: () async {
            // showHotelResultDialog(context, cruiseId: 0);
          },
        ),
      ],
    );
  }
}
