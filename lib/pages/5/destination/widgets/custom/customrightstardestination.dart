import 'package:flutter/material.dart'; 
import '../index.dart';

class CustomRightStarDestinationForm extends StatelessWidget {
  const CustomRightStarDestinationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
        DestinationsOrderableListWidget(),
        const ResetPadWidget(),
        const KeyPadWidget(),
      ],
    );
  }
}
