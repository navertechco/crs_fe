import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

/// Body
class BodyLayoutWidget extends GetView<StatelessWidget> {
  const BodyLayoutWidget(
      {Key? key, this.background, this.children, this.child, this.type = "png"})
      : super(key: key);
  final String? background;
  final List<Widget>? children;
  final String type;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = Get;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              fit: StackFit.expand,
              children: [
                if (type == "svg")
                  SvgPicture.asset(
                    background!,
                    fit: BoxFit.fill,
                    height: size.height,
                  ),
                if (type != "svg")
                  Image.asset(
                     background!,
                    fit: BoxFit.fill,
                    height: size.height,
                  ),
                SingleChildScrollView(
                  child: child ??
                      Column(
                        children: children!,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
