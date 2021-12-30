// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class AudioBlockWidget extends StatefulWidget {
//   final String _provider;
//   final String _url;
//   const AudioBlockWidget(
//       {Key key, @required String provider, @required String url})
//       : _provider = provider,
//         _url = url,
//         super(key: key);

//   @override
//   State<AudioBlockWidget> createState() => _AudioBlockWidgetState();
// }

// class _AudioBlockWidgetState extends State<AudioBlockWidget> {
//   //WebViewController _webViewController;
//   @override
//   void initState() {
//     super.initState();
//     if (!kIsWeb && Platform.isAndroid) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return Container(
//     //   child: WebView(
//     //     initialUrl: '',
//     //     javascriptMode: JavascriptMode.unrestricted,
//     //     onWebViewCreated: (WebViewController controller) {
//     //       _webViewController = controller;
//     //       Uri audioUri = Uri.dataFromString("""
//     // <iframe width="100%" height="300" scrolling="no" frameborder="no"
//     // allow="autoplay"
//     // src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/586488615&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"></iframe><div style="font-size: 10px; color: #cccccc;line-break: anywhere;word-break: normal;overflow: hidden;white-space: nowrap;text-overflow: ellipsis; font-family: Interstate,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Garuda,Verdana,Tahoma,sans-serif;font-weight: 100;"><a href="https://soundcloud.com/duncanlaurence-music" title="Duncan Laurence" target="_blank" style="color: #cccccc; text-decoration: none;">Duncan Laurence</a> · <a href="https://soundcloud.com/duncanlaurence-music/arcade" title="Arcade" target="_blank" style="color: #cccccc; text-decoration: none;">Arcade</a></div>
//     // """, mimeType: 'text/html', encoding: Encoding.getByName('utf-8'));
//     //       _webViewController.loadUrl(audioUri.toString());
//     //     },
//     //   ),
//     // );
//     return Container();
//   }
// }
