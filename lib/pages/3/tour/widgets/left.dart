


import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart'; 
import '../../../index.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var destinationData = getParam("DESTINATION_DATA")["value"];
    var images = [];

    for (var destination in destinationData.keys) {
      var image = destinationData[destination][4];
      images.add(image);
    }

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
