import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitcherWidget extends StatelessWidget {
  const SwitcherWidget(
      {Key? key,
      this.title = "",
      required this.firstchild,
      required this.seccondchild})
      : super(key: key);

  final String title;
  final Widget firstchild;
  final Widget seccondchild;

  @override
  Widget build(BuildContext context) {
    bool _showFrontSide = true;
    bool _flipXAxis = true;

    void _changeRotationAxis() {
      _flipXAxis = !_flipXAxis;
    }

    void _switchCard() {
      _showFrontSide = !_showFrontSide;
      _changeRotationAxis();
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
          return Transform(
            transform: _flipXAxis
                ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
                : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
            child: widget,
            alignment: Alignment.center,
          );
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
          child: _showFrontSide ? firstchild : seccondchild,
          switchInCurve: Curves.easeInBack,
          switchOutCurve: Curves.easeInBack.flipped,
        ),
      );
    }

    return _buildFlipAnimation();
  }
}
