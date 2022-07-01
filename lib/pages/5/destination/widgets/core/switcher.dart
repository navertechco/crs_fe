import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class SwitcherWidget extends StatelessWidget {
  const SwitcherWidget(
      {Key? key,
      required this.firstchild,
      required this.seccondchild,
      required this.destination,
      required this.type,
      required this.index,
      this.isListed = false})
      : super(key: key);

  final Widget firstchild;
  final Widget seccondchild;
  final String destination;
  final String type;
  final int index;
  final bool isListed;
  @override
  Widget build(BuildContext context) {
    RxBool _showFrontSide = true.obs;
    RxBool _flipXAxis = true.obs;

    void _changeRotationAxis() {
      _showFrontSide.value = !_showFrontSide.value;
      _flipXAxis.value = !_flipXAxis.value;
    }

    void _switchCard() {
      globalctx.value.value = globalctx.value.value;
      RxList dests = globalctx.destinationlist;

      dests.contains(destination) && _showFrontSide.value
          ? dests.add(destination)
          : dests.remove(destination);

      globalctx.destinationlist = dests;
      if (isListed ||
          !validateDragDestinationOptions(destination, index, type).value) {
        _changeRotationAxis();
      } else {
        globalDestinationName.value = destination;
        globalDestinationIndex.value = index.toString();
        showDialog(
            context: context,
            builder: (context) {
              return DestinationDetailPage(
                  destination: destination, type: type, index: index);
            });
      }
    }

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
        onTap: _switchCard,
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
