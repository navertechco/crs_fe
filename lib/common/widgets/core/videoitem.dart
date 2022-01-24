import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../index.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final   item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.close(1);
      },
      child: SizedBox(
        width: 100,
        child: ContentLayoutWidget(
            child: YoutubeWidget(
              videoId: item["video"],
            ),
            text: item["title"]),
      ),
    );
  }
}
