import 'package:flutter/material.dart';

class ImageViewPage extends StatelessWidget {
  final String largeImageUrl;
   const ImageViewPage({Key? key, required this.largeImageUrl}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(child: Image.network(largeImageUrl),),
    );
  }
}
