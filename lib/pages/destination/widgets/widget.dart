import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import 'package:flutter_html/flutter_html.dart';

class DestinationWidget extends GetView<DestinationController> {
  const DestinationWidget({Key? key, required this.args}) : super(key: key);
  final dynamic args;

  @override
  Widget build(BuildContext context) {
    var title = args["title"];

    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.18,
          left: MediaQuery.of(context).size.width * 0.035,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.425,
                height: MediaQuery.of(context).size.height * 0.645,
                // margin: const EdgeInsets.all(15.0),
                // padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: YoutubeWidget(
                  videoId: "JW5meKfy3fY",
                  width: MediaQuery.of(context).size.width * 0.425,
                  height: MediaQuery.of(context).size.height * 0.645,
                ),
              ),
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

class YoutubeWidget extends StatelessWidget {
  const YoutubeWidget({
    Key? key,
    required this.videoId,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  final String videoId;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Html(
            data: """
          
            <div class="youTubeContainer">
            <iframe width="$width" height="$height"
           src="http://www.youtube.com/embed/$videoId?autoplay=1">
           </iframe>
           </div>
       
           """,
          ),
        ),
      ],
    );
  }
}
