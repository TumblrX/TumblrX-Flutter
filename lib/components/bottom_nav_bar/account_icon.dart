import 'package:flutter/material.dart';

class AccountIcon extends StatefulWidget {
  @override
  _AccountIconState createState() => _AccountIconState();
}

class _AccountIconState extends State<AccountIcon> {
  bool _isHovered = false;

  void setSelection(bool selectionState) {
    print('entered with hover state');
    // ToDO: set the provider data to the chosen account if _isHovered is true
    // else set it to null
    setState(() {
      this._isHovered = selectionState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setSelection(true),
      onEnter: (event) => setSelection(true),
      onExit: (event) => setSelection(false),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CircleAvatar(
          radius: _isHovered ? 30.0 : 25.0,
          backgroundImage:
              AssetImage('assets/icon/Tumblr_Logo_t_Icon_White.png'),
        ),
      ),
    );
  }
}
