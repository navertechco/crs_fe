import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
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
              nextlabel: "     Next >",
              onNext: () {
                processDestinations(context);
              },
              onPrevious: () {
                selectedIndex.value = selectedIndex.value - 1;
                Get.back();
              },
              width: 0.3);
        }
        return const Text("");
      }),
    );
  }
}
