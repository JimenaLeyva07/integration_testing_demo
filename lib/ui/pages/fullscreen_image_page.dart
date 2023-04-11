import 'package:flutter/material.dart';
import 'package:integration_testing_demo/models/photo_model.dart';

class FullscreenImagePage extends StatelessWidget {
  const FullscreenImagePage({super.key, required this.imageUrl});

  final PhotoModel imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check me out')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.network(
              imageUrl.src.large2X,
              fit: BoxFit.cover,
            ),
          ),
          Text(imageUrl.photographer)
        ],
      ),
    );
  }
}
