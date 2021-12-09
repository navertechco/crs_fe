import 'package:flutter/material.dart';
import './index.dart';

class ExpereinceOptionWidget extends StatelessWidget {
  const ExpereinceOptionWidget({Key? key, required this.destination})
      : super(key: key);
  final String destination;
  @override
  Widget build(BuildContext context) {
    return GoldBorderWidget(
        child: SwitcherWidget(
            destination: destination,
            firstchild: FrontOptionWidget(destination: destination),
            seccondchild: RearOptionWidget(destination: destination)
            
            
            
            ));
  }
}
