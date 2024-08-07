import 'package:flutter/material.dart';

class ZoomControls extends StatelessWidget {
  final VoidCallback zoomIn;
  final VoidCallback zoomOut;

  const ZoomControls({
    required this.zoomIn,
    required this.zoomOut,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 100,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              zoomIn();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              zoomOut();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: const Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
