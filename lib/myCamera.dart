import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kmongcamera/imageCropper.dart';
import 'package:kmongcamera/utils.dart';

class MyCamera extends StatefulWidget {
  final bool isCameraMode;
  final CameraController? cameraController;
  final String? imagePath;
  const MyCamera({
    required this.isCameraMode,
    this.cameraController,
    this.imagePath,
    super.key,
  });

  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  @override
  Widget build(BuildContext context) {
    return widget.isCameraMode
        ? Stack(
            children: [
              Center(
                child: SizedBox(
                    width: Helper(context).scaledScreenWidth(1),
                    child: CameraPreview(widget.cameraController!)),
              ),
              ImageCropper(isView: false),
            ],
          )
        : Stack(
            children: [
              Center(
                  child: Image.file(File(widget.imagePath!),
                      fit: BoxFit.fitHeight)),
              ImageCropper(
                isView: true,
              ),
            ],
          );
  }
}
