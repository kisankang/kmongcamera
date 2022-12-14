import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kmongcamera/imageCropper.dart';
import 'package:kmongcamera/myCamera.dart';
import 'package:kmongcamera/takePhotoResultPage.dart';
import 'package:kmongcamera/utils.dart';
import 'dart:math' as ma;

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({super.key});

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  bool _cameraInitialized = false;
  late CameraController _cameraController;

  @override
  void initState() {
    // 화면에 처음 진입할 때 카메라 사용을 준비 하도록 합니다.
    super.initState();
    readyToCamera();
  }

  @override
  void dispose() {
    // 화면에서 벗어날 때 카메라 제어기를 위해 OS에게 할당 받은 리소스를 정리 합니다.
    if (_cameraController != null) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  void readyToCamera() async {
    // 사용할 수 있는 카메라 목록을 OS로부터 받아 옵니다.
    final cameras = await availableCameras();
    if (0 == cameras.length) {
      print("not found any cameras");
      return;
    }

    late CameraDescription frontCamera;
    for (var camera in cameras) {
      // 저 같은 경우에는 전면 카메라를 사용해야 했기 때문에
      // 아래와 같이 코딩하여 카메라를 찾았습니다.
      if (camera.lensDirection == CameraLensDirection.back) {
        frontCamera = camera;
        break;
      }
    }

    _cameraController = CameraController(
        frontCamera, ResolutionPreset.max // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다.
        );
    _cameraController.initialize().then((value) {
      // 카메라 준비가 끝나면 카메라 미리보기를 보여주기 위해 앱 화면을 다시 그립니다.
      setState(() => _cameraInitialized = true);
    });
  }

  _mainPage(context) {
    var math;
    return GestureDetector(
        onTap: () async {
          XFile file = await _cameraController.takePicture();

          // 찍은 사진을 별도 화면으로 보여주기 위해 TakePhotoResultPage화면으로 이동 합니다.
          // 이 때 이동 하려는 화면으로 사진의 경로를 전달 합니다.
          // 참고로 TakePhotoResultPage는 Flutter에서 제공하는 클래스가 아니고
          // 제가 만든 클래스 입니다.
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TakePhotoResultPage(imagePath: file.path)));
        },
        child: Stack(
          children: [
            MyCamera(isCameraMode: true, cameraController: _cameraController),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: Helper(context).scaledScreenWidth(1),
                color: Constants.guideBoxColor,
                child: const Text(
                  '화면의 빈 영역, 아무 곳이나 터치하면\n화면 안에 담긴 모습이 촬영 됩니다.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _cameraInitialized
            ? _mainPage(context)
            : Center(
                child: CircularProgressIndicator(
                    backgroundColor: Constants.selectionColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Constants.selectionColor))));
  }
}
