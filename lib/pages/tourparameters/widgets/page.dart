// ignore_for_file: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import '../index.dart';
import './index.dart';

class TourParametersFormPage extends GetView<StatelessWidget> {
  TourParametersFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TourParametersController? ctrl;
  @override
  Widget build(BuildContext context) {
    var images = [
      "assets/custom/img/monkey.png",
      "assets/custom/img/monkey.png",
      "assets/custom/img/monkey.png",
      "assets/custom/img/monkey.png",
      "assets/custom/img/monkey.png"
    ];
    return Stack(
      children: [
        Padding(
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
              // pagination: const SwiperPagination(
              //     alignment: Alignment.bottomCenter,
              //     builder: SwiperPagination.fraction),
            ),
          ),
        ),
        TourParametersForm(
            formKey: _formKey, state: ctrl!.state, profile: false),
      ],
    );
  }
}
