/*
  Author: Passant Abdelgalil

  Description:
      A stateless widget to preview media blocks [image, GIF] in a post 
*/
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:tumblrx/utilities/constants.dart';

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
    try {
      print('image url is $_url');
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
    } catch (err) {
      return noImage();
    }
  }

  /// Open options dialog on long press on the media with
  ///  ['share post', 'download media'] options
  void _openOptionsDialog(BuildContext context, bool isFullScreenPreviewed) {
    EdgeInsets padding = MediaQuery.of(context).padding;
    double pads = padding.left + padding.right;
    double width = (MediaQuery.of(context).size.width - pads) * 0.7;

    final ButtonStyle optionButtonStyle = ButtonStyle(
      fixedSize: MaterialStateProperty.all(Size.fromWidth(width)),
      foregroundColor: MaterialStateProperty.all(
          isFullScreenPreviewed ? Colors.white : Colors.black),
      textStyle: MaterialStateProperty.all(
        TextStyle(letterSpacing: 1.2),
      ),
    );
    showDialog(
      barrierColor: Colors.black.withOpacity(.5),
      context: context,
      builder: (context) => Container(
        child: Center(
          child: Container(
            width: width,
            color: isFullScreenPreviewed ? Colors.black : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  style: optionButtonStyle,
                  onPressed: _sharePost,
                  child: Text('Share post'),
                ),
                TextButton(
                  style: optionButtonStyle,
                  onPressed: () async {
                    try {
                      await _downloadPhoto();
                      showSnackBarMessage(context,
                          'File is Downloaded Successfully', Colors.green);
                      Navigator.of(context).pop();
                    } catch (err) {
                      showSnackBarMessage(
                          context, 'Couldn\'t download the file', Colors.red);
                    }
                  },
                  child: Text('Download photo'),
                ),
                TextButton(
                  style: optionButtonStyle,
                  onPressed: _sharePhoto,
                  child: Text('Share photo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sharePost() {}
  void _sharePhoto() {}
  Future<void> _downloadPhoto() async {
    try {
      if (Platform.isAndroid) {
        // // ask for permission to storage for downloading
        final status = await Permission.storage.request();
        // // if permission is granted, proceed with downloading process
        if (status.isGranted) {
          final Directory directory = await getTemporaryDirectory();

          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }
          if (await directory.exists()) {
            final String fileName = Uri.parse(this._url).path.split('/').last;
            final String downloadPath = '${directory.path}/$fileName';
            await Dio().download(this._url, downloadPath);
            await ImageGallerySaver.saveFile(downloadPath);
          }
        } else {}
      } else {}
    } catch (err) {
      print(err);
      throw err;
    }
  }

  /// build full screen preview of the tapped media
  void _openFulScreenPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        body: GestureDetector(
          child: Container(
            child: Center(
              child: _buildImageView(
                  null, () => _openOptionsDialog(context, true)),
            ),
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildImageView(() => _openFulScreenPreview(context),
        () => _openOptionsDialog(context, false));
  }
}
