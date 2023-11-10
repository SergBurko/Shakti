import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  final String imageAssetPath;

  RoundImage({ required this.imageAssetPath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: Image.asset( imageAssetPath      ),
    );
  }
}