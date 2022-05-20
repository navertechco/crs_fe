import 'package:flutter/material.dart';

import '../../index.dart'; 

class GalleryItem extends StatelessWidget {
  final String image;
  final String title;
  final void Function() onTap;
  final data;
  const GalleryItem({
    Key? key,
    this.data,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(data["description"].split("-")[0],
                        style: KTextSytle(
                                context: context,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 204, 164, 61))
                            .getStyle()),
                    GestureDetector(
                      child: Text(data["value"]["description"],
                          style: KTextSytle(
                                  context: context,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 128, 128, 128))
                              .getStyle()),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
