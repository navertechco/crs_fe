import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/pages/profile/controller.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({Key? key, required this.cameras, required this.ctrl})
      : super(key: key);

  final List<CameraDescription> cameras;
  final ProfileController ctrl;
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();
    CameraDescription camera = widget.cameras.first;

    controller = CameraController(camera, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: GestureDetector(
            onTap: () async {
              final image = await controller.takePicture();
              final bytes = await image.readAsBytes();
              final buffer = Uint8List.view(bytes.buffer);
              final base64 = base64Encode(buffer);
              var session = getContext('session');
              session['avatar'] = base64;
              setContext('session', session);
              Get.back();
            },
            child: ClipRRect(
              child:
                  RotatedBox(quarterTurns: 3, child: CameraPreview(controller)),
            ),
          ),
        ),
      ),
    );
  }
}
