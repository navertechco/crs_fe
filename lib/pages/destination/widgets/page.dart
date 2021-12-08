import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import '../index.dart';
import 'index.dart';

class DestinationWidget extends GetView<DestinationController> {
  const DestinationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = "";

    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.425,
                  height: MediaQuery.of(context).size.height * 0.78,
                  // margin: const EdgeInsets.all(15.0),
                  // padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Scrollbar(child: SingleChildScrollView())),
              // Image.asset(image),
              Text(title,
                  style: const TextStyle(fontSize: 30, color: Colors.white)),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.18,
          left: MediaQuery.of(context).size.width * 0.55,
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.75,
                  // margin: const EdgeInsets.all(15.0),
                  // padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                        child: Column(children: [
                      const CustomStarDestinationForm(),
                      const CustomStarDestinationForm(),
                      const CustomStarDestinationForm(),
                      const CustomStarDestinationForm(),
                      const CustomStarDestinationForm(),
                      const CustomKeypadWidget(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      )
                    ])),
                  )),
              // Image.asset(image),
              Text(title,
                  style: const TextStyle(fontSize: 30, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
