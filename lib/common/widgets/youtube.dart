import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';



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
           src="https://www.youtube.com/embed/$videoId?autoplay=1">
           </iframe>
           </div>
       
           """,
          ),
        ),
      ],
    );
  }
}