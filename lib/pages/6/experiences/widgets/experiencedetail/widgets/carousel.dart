import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
    this.experience,
  }) : super(key: key);
  final experience;
  @override
  Widget build(BuildContext context) {
    var expData = experiences
        .toList()
        .firstWhere((element) => element["description"] == experience)["value"];
    var images = [];
    var datas = [];

    for (var data in expData["activities"]) {
      images.add(data["image"]);
      datas.add(data);
    }

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
                          child: YoutubeWidget(
                            videoId: datas[index]["video"],
                          )),
                    ],
                  ),
                  "Close");
            },
            child: Image.asset(images[index],
                // fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.05),
          );
        },
        autoplay: false,
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
