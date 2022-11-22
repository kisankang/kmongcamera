import 'package:flutter/material.dart';

class ImageCropper extends StatelessWidget {
  final bool isView;
  const ImageCropper({required this.isView, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
              isView ? Colors.white : Colors.black.withOpacity(0),
              BlendMode.srcOut), // This one will create the magic
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode
                        .dstOut), // This one will handle background + difference out
              ),
              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            height: 300,
            width: 300,
            child: Image.asset(
              'images/box_frame.png',
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
