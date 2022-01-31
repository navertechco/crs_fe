import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';
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
                if (globalctx.promoted.value.isNotEmpty) {
                  Get.toNamed("/Experiences");
                } else {
                  SweetAlert.show(context,
                      title: "Promote any destination is required",
                      subtitle: 'error',
                      style: SweetAlertStyle.error, onPress: (bool isConfirm) {
                    Get.close(1);
                    return false;
                  });
                }
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
