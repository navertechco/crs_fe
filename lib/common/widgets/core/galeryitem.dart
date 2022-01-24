
import 'package:flutter/material.dart';

class GalleryItem extends StatelessWidget {
  final String image;
  final String title;
  final void Function() onTap;
  const GalleryItem({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.6,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
