// ignore_for_file: file_names, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import '../index.dart';
import './index.dart';

class TourFormPage extends GetView<StatelessWidget> {
  TourFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TourController? ctrl;
  @override
  Widget build(BuildContext context) {
    

    return Stack(
      children: [
        LeftWidget(),
        RightWidget(formKey: _formKey, state: ctrl!.state, profile: false),
      ],
    );
  }
}

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var images = [
      "assets/custom/img/monkey.png",
      "assets/custom/img/monkey.png",
      "assets/custom/img/monkey.png",
      "assets/custom/img/monkey.png",
      "assets/custom/img/monkey.png"
    ];
    return Padding(
      padding: EdgeInsets.only(
          left: 50,
          top: MediaQuery.of(context).size.height * 0.055,
          right: 400),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.48,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(images[index],
                // fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.05);
          },
          autoplay: false,
          itemCount: images.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
