import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final double imageWidth;
  final double imageHeight;
  final String imageName;
  final BoxShape imageShape;

  const ImageWidget(
    this.imageWidth, 
    this.imageHeight, 
    this.imageName, 
    {this.imageShape = BoxShape.rectangle,
    super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        shape: imageShape,
        image: DecorationImage(
          image: AssetImage(
            imageName,
          ),
        ),
      ),
    );
  }
}
