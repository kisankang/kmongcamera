import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kmongcamera/imageCropper.dart';
import 'package:kmongcamera/myCamera.dart';
import 'package:kmongcamera/utils.dart';
import 'dart:math' as math;

class TakePhotoResultPage extends StatelessWidget {
  const TakePhotoResultPage({required this.imagePath, super.key});
  final String imagePath;

  _guideBoxAtBottom(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      color: Constants.guideBoxColor,
      alignment: Alignment.center,
      child: const Text(
        'this is guideBox',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        body: Stack(
          children: [
            MyCamera(isCameraMode: false, imagePath: imagePath),
            Align(
                alignment: Alignment.bottomCenter,
                child: _guideBoxAtBottom(context))
          ],
        ));
  }
}
