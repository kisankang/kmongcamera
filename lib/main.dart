import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:kmongcamera/takePhotoPage.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TakePhotoPage(),
  ));
}
