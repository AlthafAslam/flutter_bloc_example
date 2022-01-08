import 'package:flutter/material.dart';
import 'package:jify_flutter_app/src/ui/image_view_page.dart';

class ImageViewCard extends StatefulWidget {
  final String previewImageUrl;
  final String largerImageUrl;

  const ImageViewCard({Key? key, required this.previewImageUrl, required this.largerImageUrl}) : super(key: key);

  @override
  _ImageViewCardState createState() => _ImageViewCardState();
}

class _ImageViewCardState extends State<ImageViewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageViewPage(largeImageUrl: widget.largerImageUrl)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(widget.previewImageUrl),
          ),
        ),
      ),
    );
  }
}
