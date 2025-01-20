import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class UniversalImage extends StatelessWidget {
  final String imagePath;
  final BoxFit? fit;
  final double? height;
  final double? width;

  const UniversalImage( {
    Key? key,
    required this.imagePath,
    this.fit,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath.toLowerCase().endsWith('.json')) {
      return Lottie.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
      );
    }

    if (imagePath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
      );
    }

    if (Uri.tryParse(imagePath)?.hasAbsolutePath ?? false) {
      return Image.network(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else if (File(imagePath).existsSync()) {
      return Image.file(
        File(imagePath),
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      return Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
} 