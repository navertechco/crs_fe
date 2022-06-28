import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:naver_crs/index.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var destinationData;
    try {
      destinationData = getParam("DESTINATION_DATA")["value"];
    } catch (e) {
      destinationData = {};
    }
    var images = [];

    for (var destination in destinationData.keys) {
      var image = destinationData[destination][4];
      images.add(image);
    }

    return Padding(
      padding: EdgeInsets.only(
          left: 50,
          top: MediaQuery.of(context).size.height * isMobile * 0.09,
          right: 400),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * isMobile * 0.97,
        width: MediaQuery.of(context).size.width * isMobile * 0.9,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(images[index],
                // fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * isMobile * 0.07);
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
