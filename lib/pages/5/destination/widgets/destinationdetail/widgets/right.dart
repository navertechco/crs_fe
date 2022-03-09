import 'package:flutter/material.dart';

import '../../index.dart';

class RightWidget extends StatelessWidget {
  const RightWidget({
    Key? key,
    required this.destination,
    required this.index,
    required this.ctrl,
    required this.formKey,
  }) : super(key: key);

  final destination;
  final index;
  final DestinationDetailController ctrl;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.5,
          top: MediaQuery.of(context).size.height * 0.18),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.45,
        // color: Colors.red[50],
        child: SingleChildScrollView(
          child:
              CustomStarDestinationForm(destination: destination, index:index, ctrl: ctrl, formKey:formKey),
        ),
      ),
    );
  }
}
