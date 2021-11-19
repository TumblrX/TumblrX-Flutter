import 'package:flutter/material.dart';

class MediaWidget extends StatelessWidget {
  final String _url;
  final double _width;
  final double _height;
  MediaWidget(this._url, this._width, this._height);

  Widget noImage() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(
          Icons.error,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      onLongPress: null,
      child: Padding(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Image.network(
          this._url,
          width: this._width,
          height: this._height,
          loadingBuilder: (context, child, loadingProgress) =>
              (loadingProgress == null) ? child : CircularProgressIndicator(),
          errorBuilder: (context, error, stackTrace) => noImage(),
        ),
      ),
    );
    ;
  }
}
