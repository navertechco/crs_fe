import 'package:flutter/material.dart';

import '../../../../../index.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label: "Date: ",
            ),
            CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label: "25TH April 2022",
            ),
          ],
        ),
        Divider(color: Color.fromARGB(255, 0, 0, 0)),
        CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "Destination: Cuenca",
        ),
        Divider(color: Color.fromARGB(255, 0, 0, 0)),
      ],
    );
  }
}
