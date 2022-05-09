import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../../../index.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
    this.service,
  }) : super(key: key);
  final service;
  @override
  Widget build(BuildContext context) {
    var srvData = filteredsrv
        .toList()
        .firstWhere((element) => element.description == service)
        .value;
    var images = [];
    var datas = [];
 

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.3,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showCustomDialog(
                  context,
                  Stack(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child:  Text("Video")),
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
