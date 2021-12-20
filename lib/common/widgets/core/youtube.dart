import 'package:flutter/material.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Container(
            color: Color.fromARGB(255, 0, 0, 255),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: YoutubePlayer(
              aspectRatio: 16 / 9,
              controller: _controller,
              // showVideoProgressIndicator: true,
            ),
          ),
        ),
      ],
    );
  }
}
