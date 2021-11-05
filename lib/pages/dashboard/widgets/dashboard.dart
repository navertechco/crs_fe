import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/widgets/index.dart';

import '../index.dart';

/// hello
///
///

class DashboardWidget extends GetView<DashboardController> {
  const DashboardWidget({Key? key}) : super(key: key);

  Future<void> share() async {
    await FlutterShare.share(
        title: 'TRVIIA',
        text: 'Entra y juega a TRIVIA',
        linkUrl: 'https://www.trivia.net/',
        chooserTitle: 'juega TRIVIA');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: Get.height * 0.001,
            left: Get.width * 0.3,
            child: SvgPicture.asset(
              "assets/custom/svg/images/LogoSlogan2.svg",
              width: Get.width * 0.35,
            ),
          ),
          Positioned(
            top: Get.height * 0.30,
            left: Get.width * 0.50,
            child: SquareOptionWidget(
                borderRadius: 8.0,
                padding: 50,
                child: RadiantGradientMask(
                  colors: GradientColors.farawayRiver,
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: Get.width * 0.165,
                  ),
                ),
                ontap: () {
                  share();
                }),
          ),
          Positioned(
            top: Get.height * 0.30,
            left: Get.width * 0.08,
            child: SquareOptionWidget(
                key: const ObjectKey("h"),
                borderRadius: 8.0,
                padding: 50,
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.green,
                  size: Get.width * 0.165,
                ),
                url: "/Home"),
          ),
          //
          Positioned(
            top: Get.height * 0.55,
            left: Get.width * 0.50,
            child: SquareOptionWidget(
                key: const ObjectKey("b"),
                borderRadius: 8.0,
                padding: 50,
                child: Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.green,
                  size: Get.width * 0.165,
                ),
                url: "/BuyCredits"),
          ),
          Positioned(
            top: Get.height * 0.55,
            left: Get.width * 0.08,
            child: SquareOptionWidget(
                key: const ObjectKey("r"),
                borderRadius: 8.0,
                padding: 50,
                child: Icon(
                  Icons.score_outlined,
                  color: Colors.green,
                  size: Get.width * 0.165,
                ),
                url: "/TournamentResult"),
          ),
          Positioned(
            top: Get.height * 0.45,
            left: Get.width * 0.33,
            child: RawMaterialButton(
              key: const ObjectKey("q"),
              onPressed: () {
                controller.onJoinTournament(context);
                // Get.toNamed("/Questionary");
              },
              elevation: 1.0,
              fillColor: Colors.white,
              child: RadiantGradientMask(
                colors: GradientColors.farawayRiver,
                child: Icon(
                  Icons.play_circle_sharp,
                  color: Colors.white,
                  size: Get.height * 0.15,
                ),
              ),
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
