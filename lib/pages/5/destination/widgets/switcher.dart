import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'index.dart';

class SwitcherWidget extends StatelessWidget {
  const SwitcherWidget(
      {Key? key,
      required this.firstchild,
      required this.seccondchild,
      required this.destination})
      : super(key: key);

  final Widget firstchild;
  final Widget seccondchild;
  final String destination;

  @override
  Widget build(BuildContext context) {
    RxBool _showFrontSide = true.obs;
    RxBool _flipXAxis = true.obs;

  
 
    Widget _transitionBuilder(Widget widget, Animation<double> animation) {
      final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
      return AnimatedBuilder(
        animation: rotateAnim,
        child: widget,
        builder: (context, widget) {
          final isUnder = (ValueKey(_showFrontSide) != key);
          var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
          tilt *= isUnder ? -1.0 : 1.0;
          final value =
              isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
          return Obx(() {
            return Transform(
              transform: _flipXAxis.value
                  ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
                  : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
              child: widget,
              alignment: Alignment.center,
            );
          });
        },
      );
    }

    Widget _buildFlipAnimation() {
      return GestureDetector(
        onTap: () {
          var key = destination;
          if (globalctx.Keys.contains(destination)) {
            showDialog(
                context: context,
                builder: (context) {
                  return DestinationDetailPage(destination: destination);
                });
          }
          if (!globalctx.Keys.contains(key)) {
            globalctx.Keys.add(key);
            globalctx.destinationDragData.value.add(Obx(() {
              return globalctx.Keys.contains(key)
                  ? Row(
                      children: [
                        DestinationOptionWidget(destination: key),
                        !globalctx.Completed.contains(key)
                            ? GestureDetector(
                                onTap: () {
                                  if (globalctx.Keys.contains(key)) {
                                    globalctx.Completed.remove(key);
                                    var index = globalctx.Keys.indexWhere(
                                        (element) => element == key);
                                    globalctx.Keys.removeAt(index);
                                    globalctx.destinationDragData.value
                                        .removeAt(index);
                                  }
                                },
                                child: Image.asset(
                                    "assets/custom/img/redmark.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.02),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (globalctx.Keys.contains(key)) {
                                    var index = globalctx.Keys.indexWhere(
                                        (element) => element == key);
                                    globalctx.Keys.removeAt(index);
                                    globalctx.destinationDragData.value
                                        .removeAt(index);
                                  }
                                },
                                child: Image.asset(
                                    "assets/custom/img/greencheck.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.02),
                              )
                      ],
                    )
                  : Text("");
            }));
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          transitionBuilder: _transitionBuilder,
          layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
          child: Obx(() {
            return _showFrontSide.value ? firstchild : seccondchild;
          }),
          switchInCurve: Curves.easeInBack,
          switchOutCurve: Curves.easeInBack.flipped,
        ),
      );
    }

    return _buildFlipAnimation();
  }
}
