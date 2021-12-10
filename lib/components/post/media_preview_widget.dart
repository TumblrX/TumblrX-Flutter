/*
  Author: Passant Abdelgalil

  Description:
      A stateless widget to preview media blocks [image, GIF] in a post 
*/
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

//import 'package:cached_network_image/cached_network_image.dart';
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

  Widget _buildImageView(void Function() onTap, void Function() onLongPress) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: CachedNetworkImage(
        imageUrl: this._url,
        width: this._width,
        height: this._height,
        placeholder: (cts, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (ctx, url, error) => noImage(),
      ),
    );
  }

  /// Open options dialog on long press on the media with
  ///  ['share post', 'download media'] options
  void _openOptionsDialog(BuildContext context, Color color) {
    showDialog(
      context: context,
      builder: (context) => Container(
        child: Column(
          children: [
            TextButton(
              onPressed: _sharePost,
              child: Text('Share post'),
            ),
            const Divider(
              thickness: 3,
            ),
            TextButton(
              onPressed: _downloadPhoto,
              child: Text('Download photo'),
            ),
            const Divider(
              thickness: 3,
            ),
            TextButton(
              onPressed: _sharePhoto,
              child: Text('Share photo'),
            ),
          ],
        ),
      ),
    );
  }

  void _sharePost() {}
  void _sharePhoto() {}
  void _downloadPhoto() async {
    // ask for permission to storage for downloading
    final status = await Permission.storage.request();
    // if permission is granted, proceed with downloading process
    if (status.isGranted) {
      final externalStorageDirectory = await getExternalStorageDirectory();
      FlutterDownloader.enqueue(
        url: this._url,
        savedDir: externalStorageDirectory.path,
        saveInPublicStorage: true,
      );
    }
  }

  /// build full screen preview of the tapped media
  MaterialPageRoute<void> _openFulScreenPreview() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              body: GestureDetector(
                child: Container(
                  child: Center(
                    child: _buildImageView(
                        null, () => _openOptionsDialog(context, Colors.black)),
                  ),
                  color: Colors.black,
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildImageView(
        () => Navigator.of(context).push(_openFulScreenPreview()),
        () => _openOptionsDialog(context, Colors.white));
  }
}
