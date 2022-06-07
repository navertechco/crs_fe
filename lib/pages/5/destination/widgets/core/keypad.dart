import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe

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
        var d = arrivalDate.value;
        if (!globalctx["destinationlist"] != null) {
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
                  goto("Customer");
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
                  resetAllDestinations();
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
                onPressed: () async {
                  if (dayleft.value == 0) {
                    await processDestinations(context);
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
                      height: 0.15,
                      backgroundColor: Colors.white,
                      buttonColor: Colors.black,
                    );
                  }
                },
              ),
            ],
          );
        }
        return const Text('');
      }),
    );
  }
}
