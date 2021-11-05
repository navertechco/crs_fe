import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/widgets/index.dart';

import '../index.dart';

/// hello
// ignore: must_be_immutable
class RankingWidget extends GetView<RankingController> {
  double padding = 1.5;

  RankingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: Get.height * padding * 0.06,
          left: Get.width * 0.05,
          child: RankingAvatarWidget(padding: padding),
        ),
        Positioned(
          top: Get.height * padding * 0.03,
          left: Get.width * 0.33,
          child: RankingAvatarWidget(padding: padding),
        ),
        Positioned(
          top: Get.height * padding * 0.06,
          left: Get.width * 0.60,
          child: RankingAvatarWidget(padding: padding),
        ),
        Positioned(
          top: Get.height * padding * 0.18,
          left: Get.width * 0.15,
          child: const RankingDetailWidget(
              ranking: 1, gamer: "jose cuevas", score: 100),
        ),
        Positioned(
          top: Get.height * padding * 0.24,
          left: Get.width * 0.15,
          child: const RankingDetailWidget(
              ranking: 2, gamer: "jose cuevas", score: 100),
        ),
        Positioned(
          top: Get.height * padding * 0.30,
          left: Get.width * 0.15,
          child: const RankingDetailWidget(
              ranking: 3, gamer: "jose cuevas", score: 100),
        ),
        Positioned(
          top: Get.height * padding * 0.36,
          left: Get.width * 0.15,
          child: const RankingDetailWidget(
              ranking: 4, gamer: "jose cuevas", score: 100),
        ),
        Positioned(
          top: Get.height * padding * 0.42,
          left: Get.width * 0.15,
          child: const RankingDetailWidget(
              ranking: 5, gamer: "jose cuevas", score: 100),
        ),
      ],
    );
  }
}

class RankingDetailWidget extends StatelessWidget {
  const RankingDetailWidget(
      {Key? key,
      required this.gamer,
      required this.score,
      required this.ranking})
      : super(key: key);
  final String? gamer;
  final int? score;
  final int? ranking;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.6,
      height: Get.height * 0.08,
      child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const RankingAvatarWidget(padding: 0.4),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Text(ranking!.toString()),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Text(gamer!),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: SvgPicture.asset(
                              "assets/custom/svg/images/BackgroundSquare.svg",
                              fit: BoxFit.cover, // <-- (1)
                              width: kDefaultPadding * 2.9,
                            ),
                          ),
                          Positioned(
                            top: Get.height * 0.017,
                            left: Get.width * 0.001,
                            child: const Icon(
                              Icons.star,
                              size: kDefaultPadding * 1.3,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            top: Get.height * 0.021,
                            left: Get.width * 0.05,
                            child: Text(
                              score!.toString(),
                              style: TextStyle(
                                fontSize: Get.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class RankingAvatarWidget extends StatelessWidget {
  const RankingAvatarWidget({
    Key? key,
    required this.padding,
  }) : super(key: key);

  final double padding;

  @override
  Widget build(BuildContext context) {
    return RadiantGradientMask(
      colors: GradientColors.flyHigh,
      child: SquareOptionWidget(
          borderRadius: 8.0,
          padding: 10,
          child: Image.asset(
            "assets/custom/png/avatar2.png",
            fit: BoxFit.cover,
            height: Get.height * padding * 0.08,
          ),
          url: "/BuyCredits"),
    );
  }
}
