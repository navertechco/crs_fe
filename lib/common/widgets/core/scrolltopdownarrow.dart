import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrollTopDownArrows extends StatelessWidget {
  const ScrollTopDownArrows({
    Key? key,
    required ScrollController controller,
  })  : _controller = controller,
        super(key: key);

  final ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              _controller.jumpTo(_controller.position.minScrollExtent);
            },
            child: Text("\u2191",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.normal,
                )))),
        TextButton(
            onPressed: () {
              _controller.jumpTo(_controller.position.maxScrollExtent);
            },
            child: Text("\u2193",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.normal,
                )))),
      ],
    );
  }
}
