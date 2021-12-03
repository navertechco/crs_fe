import 'package:flutter/material.dart'; 

class GalleryItem extends StatelessWidget {
  final String image;

  const GalleryItem({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, height: MediaQuery.of(context).size.height * 0.4),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }
}
