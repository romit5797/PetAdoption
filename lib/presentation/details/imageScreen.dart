import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String url;
  const ImageScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Theme.of(context).colorScheme.inverseSurface),
                padding: const EdgeInsets.all(40),
                onPressed: () => Navigator.pop(context)),
          )),
      body: InteractiveViewer(
        panEnabled: true, // Set it to false
        boundaryMargin: const EdgeInsets.all(5),
        minScale: 0.5,
        maxScale: 5,
        child: Center(
          child: Image.network(
            url,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
