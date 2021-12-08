import 'package:flutter/material.dart';

import 'customformlabel.dart';

class CustomKeypadWidget extends StatelessWidget {
  const CustomKeypadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.107),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: const CustomFormLabelWidget(
                    label: "        Previous", fontWeight: FontWeight.normal),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.225),
              GestureDetector(
                onTap: () {},
                child: const CustomFormLabelWidget(
                    label: "Next", fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
