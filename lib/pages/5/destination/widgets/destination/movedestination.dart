import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../index.dart';
import '../index.dart';

void moveDestinationFunction(String key, BuildContext context) {
  if (!globalctx.Keys.contains(key)) {
    globalctx.Keys.add(key);
    globalctx.destinationDragData.value.add(Obx(() {
      return globalctx.Keys.contains(key)
          ? Row(
              children: [
                DestinationOptionWidget(destination: key),
                !globalctx.promoted.contains(key)
                    ? GestureDetector(
                        onTap: () {
                          if (globalctx.Keys.contains(key)) {
                            var index = globalctx.Keys.indexWhere(
                                (element) => element == key);
                            globalctx.Keys.removeAt(index);
                            globalctx.destinationDragData.value.removeAt(index);
                          }
                        },
                        child: Image.asset("assets/custom/img/redmark.png",
                            width: MediaQuery.of(context).size.width * 0.02),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (globalctx.Keys.contains(key)) {
                            globalctx.promoted.remove(key);
                            var index = globalctx.Keys.indexWhere(
                                (element) => element == key);
                            globalctx.Keys.removeAt(index);
                            globalctx.destinationDragData.value.removeAt(index);
                          }
                        },
                        child: Image.asset("assets/custom/img/greencheck.png",
                            width: MediaQuery.of(context).size.width * 0.02),
                      )
              ],
            )
          : Text("");
    }));
  }
}
