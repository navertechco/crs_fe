import 'dart:math';
import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/6/services/widgets/servicecedetail/widgets/index.dart';

// ignore: must_be_immutable
class SwitcherWidget extends StatelessWidget {
  SwitcherWidget(
      {Key? key,
      required this.firstchild,
      required this.seccondchild,
      required this.service,
      this.suggested = false})
      : super(key: key);

  final Widget firstchild;
  final Widget seccondchild;
  final String service;
  bool suggested;

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
      RxList exps = globalctx.servicelist;

      exps.contains(service) && _showFrontSide.value
          ? exps.add(service)
          : exps.remove(service);

      globalctx.servicelist = exps;
      suggested = getServiceState(service) == "suggested";

      if (suggested) {
        _changeRotationAxis();
      } else {
        showCustomDialog(
            context, ServiceDetailWidget(service: service), "Close",
            buttonColor: Colors.white);
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
      return TextButton(
        onPressed: _switchCard,
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
