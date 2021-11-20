/*
Author: Passant Abdelgalil
Description: 
    The top navigation bar component to be used in 'Feed Screen',
    with taps ['following', 'stuff for you'] and animated tumblr icon

*/
import 'package:flutter/material.dart';
import 'package:tumblrx/components/top_nav_bar/tumblrx_icon.dart';

class TopNavBar extends StatelessWidget {
  //constanst for rendering the widget

  /// tumblr logo icon width
  final double _tumblrIconWidth = 30.0;

  /// tab bar label font size
  final double _labelFontSize = 16.0;

  /// tab bar padding on right
  final double _tapBarRightPadding = 60.0;

  /// tab bar indicator with
  final double _indicatorBorderWidth = 3.0;

  /// tab bar indicator horizontal insets
  final double _indicatorBorderHorizontalInsets = 3.0;

  /// tab bar label padding applied horizontally
  final double _horizontalLabelPadding = 10.0;

  /// tab bar label padding applied vertically
  final double _verticalLabelPadding = 3.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: TumblrXIcon(),
      leadingWidth: _tumblrIconWidth,
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(
                horizontal: _horizontalLabelPadding,
                vertical: _verticalLabelPadding),
            labelColor: Colors.blueAccent,
            padding: EdgeInsets.only(right: _tapBarRightPadding),
            enableFeedback: false,
            labelStyle: TextStyle(fontSize: _labelFontSize),
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide:
                  BorderSide(width: _indicatorBorderWidth, color: Colors.blue),
              insets: EdgeInsets.symmetric(
                  horizontal: _indicatorBorderHorizontalInsets),
            ),
            tabs: [
              Text('Following'),
              Text('Stuff for you'),
            ],
          ),
        ],
      ),
    );
  }
}
