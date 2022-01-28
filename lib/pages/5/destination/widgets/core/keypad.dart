import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../../../index.dart'; 




class KeyPadWidget extends StatelessWidget {
  const KeyPadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.0,
        left: MediaQuery.of(context).size.width * 0.51,
      ),
      child: Obx(() {
        if (!globalctx.destinationlist.isNotEmpty) {
          return CustomKeypadWidget(
              prevlabel: "< Previous",
              nextlabel: "Next >",
              onNext: () {
                Get.toNamed("/Experiences");
              },
              onPrevious: () {
                
                Get.back();
              },
              width: 0.3);
        }
        return const Text("");
      }),
    );
  }
}