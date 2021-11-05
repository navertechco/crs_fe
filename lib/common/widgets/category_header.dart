import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';

class CategoryHeaderWidget extends StatefulWidget {
  const CategoryHeaderWidget({Key? key, required this.title}) : super(key: key);
  final String? title;

  @override
  State<CategoryHeaderWidget> createState() => _CategoryHeaderWidgetState();
}

class _CategoryHeaderWidgetState extends State<CategoryHeaderWidget> {
  double left = kSize.width;

  double top = kSize.height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: kDefaultPadding / 10,
          left: kDefaultPadding * 2,
          child: Container(
              height: kDefaultPadding * 4,
              width: kDefaultPadding * 20,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: Colors.white),
              child: Center(
                child: SvgPicture.asset(
                  'assets/custom/svg/images/SquareBackground.svg',
                  fit: BoxFit.fitWidth,
                ),
              )),
        ),
        Positioned(
            top: kDefaultPadding * 2,
            left: kDefaultPadding * 2.5,
            child: SvgPicture.asset(
              'assets/custom/svg/icons/BrainIcon.svg',
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
              width: kDefaultPadding * 2,
            )),
        Positioned(
            top: kDefaultPadding * 2,
            left: kDefaultPadding * 5,
            child: Text(widget.title!,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold)
                    .copyWith(color: Colors.white))),
      ],
    );
  }
}
