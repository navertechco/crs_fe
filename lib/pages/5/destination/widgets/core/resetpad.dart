import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../index.dart';

class ResetPadWidget extends StatelessWidget {
  const ResetPadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.0,
        left: MediaQuery.of(context).size.width * 0.7,
      ),
      child: Obx(() {
        if (!globalctx.destinationlist.isNotEmpty) {
          return CustomKeypadWidget(
              prevlabel: "< Reset >",
              nextlabel: "",
              onPrevious: () {
                globalctxReset();
                
              },
              width: 0.01);
        }
        return const Text("");
      }),
    );
  }
}
