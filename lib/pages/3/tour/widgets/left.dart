import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    var images = [
      "1x/Recurso_448mdpi.png",
      "1x/Recurso_444mdpi.png",
      "1x/Recurso_440mdpi.png",
      "1x/Recurso_478mdpi.png",
      "1x/Recurso_457mdpi.png"
    ];

  

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * isMobile * 0.01,
        left: MediaQuery.of(context).size.width * isMobile * 0.05,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * isMobile * 0.9,
        width: MediaQuery.of(context).size.width * isMobile * 0.4,
        child: Swiper(
          containerHeight: 100,
          containerWidth: 100,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset("assets/images/" + images[index]);
          },
          autoplay: true,
          autoplayDelay: 5000,
          itemCount: images.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
