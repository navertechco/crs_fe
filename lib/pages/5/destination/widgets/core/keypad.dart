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
        left: MediaQuery.of(context).size.width * 0.75,
      ),
      child: Obx(() {
        if (!globalctx.destinationlist.isNotEmpty) {
          return Row(
            children: [
              TextButton(
                child: Text("Previous",
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                        .getStyle()),
                onPressed: () {
                  selectedIndex.value = pageList.indexOf("Customer");
                  Get.toNamed("/Customer");
                },
              ),
              TextButton(
                child: Text("Reset",
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                        .getStyle()),
                onPressed: () {
                  globalctxReset();
                },
              ),
              TextButton(
                child: Text("Next",
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                        .getStyle()),
                onPressed: () {
                  if (dayleft.value == 0) {
                    if (globalctx.experienceDragData.value.keys
                        .toList()
                        .isEmpty) {
                      processDestinations(context);
                    } else {
                      goto("Experiences");
                    }
                  } else {
                    showCustomDialog(
                      context,
                      Text(
                          "You have $dayleft left, would you like to assign to another destination?",
                          style: KTextSytle(
                                  context: context,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)
                              .getStyle()),
                      "Close",
                      backgroundColor: Colors.white,
                      buttonColor: Colors.white,
                    );
                  }
                },
              ),
            ],
          );
        }
        return const Text("");
      }),
    );
  }
}
