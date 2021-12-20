import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pdf/pdf.dart';
import '../../index.dart';
import 'widgets/index.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'index.dart';
import 'package:flutter/rendering.dart';
import 'package:printing/printing.dart';

class ResumePage extends GetView<ResumeController> {
  ResumePage({Key? key}) : super(key: key);

  final Map<String, GlobalKey<State<StatefulWidget>>> keys = {
    "cover": GlobalKey(),
    "header": GlobalKey(),
    "dest": GlobalKey(),
    "end": GlobalKey()
  };

  void _printScreen() {
    Printing.layoutPdf(
        // dynamicLayout: false,
        format: PdfPageFormat.a4,
        onLayout: (PdfPageFormat format) async {
          final doc = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

          for (var key in globalctx.keys.keys) {
            final image = await WidgetWraper.fromKey(key: globalctx.keys[key]!);

            doc.addPage(pw.Page(
                pageFormat: PdfPageFormat.a4,
                build: (pw.Context context) {
                  return pw.Expanded(
                      child: pw.Center(
                    child: pw.Flexible(
                        child: pw.Image(image, width: 500, height: 700)),
                  ));
                }));
          }

          return doc.save();
        });
  }

  Widget _buildView(BuildContext _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/resume.png",
        child: Stack(
          children: [
            ResumeWidget(pkey: keys),
            Positioned(
              left: MediaQuery.of(_context).size.width * 0.4,
              top: MediaQuery.of(_context).size.height * 1.85,
              child: RoundedFormButton(
                  label: " Print",
                  onTap: () {
                    _printScreen();
                  }),
            ),
          ],
        ),
        text: "");
  }

  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width * 0.92,
            top: MediaQuery.of(context).size.height * 0.5,
            child: ScrollTopDownArrows(controller: _controller),
          ),
        ],
      ),
      body: Scrollbar(
          child: SingleChildScrollView(
        controller: _controller,
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 2,
            child: _buildView(context)),
      )),
    );
  }
}

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
