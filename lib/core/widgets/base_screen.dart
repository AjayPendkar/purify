import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;

  const BaseScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: ErrorHandler(child: child),
      ),
    );
  }
}

class ErrorHandler extends StatelessWidget {
  final Widget child;

   ErrorHandler({Key? key, required this.child}) : super(key: key) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 40),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(color: Colors.grey[800]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.offAllNamed('/'),
              child: const Text('Restart App'),
            ),
          ],
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
      ],
    );
  }
} 