/*
  Author: Passant Abdelgalil

  Description:
      A stateless widget to preview media blocks [image, GIF] in a post 
*/
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class MediaWidget extends StatelessWidget {
  /// URL of the media to embed
  final String _url;

  /// width of the media frame
  final double _width;

  /// height of the media frame
  final double _height;

  MediaWidget(this._url, this._width, this._height);

  /// Returns an error widget on loading failuer
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

  /// Open options dialog on long press on the media with
  ///  ['share post', 'download media'] options
  void _openOptionsDialog() {}

  /// build full screen preview of the tapped media
  void _openFulScreenPreview() {}

  @override
  Widget build(BuildContext context) {
    try {
      print(this._url);
      return GestureDetector(
        onTap: _openFulScreenPreview,
        onLongPress: _openOptionsDialog,
        child: Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: CachedNetworkImage Image.network(
            this._url,
            width: this._width,
            height: this._height,
            loadingBuilder: (context, child, loadingProgress) =>
                (loadingProgress == null) ? child : CircularProgressIndicator(),
            errorBuilder: (context, error, stackTrace) => noImage(),
          ),
        ),
      );
    } catch (error) {
      return Container(
        child: Center(
          child: Icon(Icons.error),
        ),
      );
    }
  }
}
