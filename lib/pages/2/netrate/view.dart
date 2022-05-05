import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import '../../index.dart';
import 'widgets/index.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'index.dart';
import 'package:printing/printing.dart';

class NetRatePage extends GetView<NetRateController> {
  NetRatePage({Key? key}) : super(key: key);

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
            NetRateWidget(pkeys: keys),
          ],
        ),
        text: "");
  }

  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
        bottomNavigationBar: NavBarWidget(),
      ),
    );
  }
}
