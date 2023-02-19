import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final double imageWidth;
  final double imageHeight;
  final String imageName;

  const ImageWidget(
    this.imageWidth, 
    this.imageHeight, 
    this.imageName, 
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            imageName,
          ),
        ),
      ),
    );
  }
}
