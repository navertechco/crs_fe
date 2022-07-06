import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
    this.service,
  }) : super(key: key);
  final service;
  @override
  Widget build(BuildContext context) {
    var images = [];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.3,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return TextButton(
            onPressed: () {
              showCustomDialog(
                  context,
                  Stack(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text("Video")),
                    ],
                  ),
                  "Close");
            },
            child: Text("Image"),
          );
        },
        autoplay: false,
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
