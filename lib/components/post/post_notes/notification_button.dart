import 'package:flutter/material.dart';

class NotificationButton extends StatefulWidget {
  bool _isOn;
  NotificationButton({Key key, @required bool isOn})
      : _isOn = isOn,
        super(key: key);

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      enableFeedback: false,
      onPressed: () {
        // send request
        setState(() {
          widget._isOn = !widget._isOn;
        });
      },
      icon: widget._isOn
          ? Icon(Icons.notifications)
          : Icon(
              Icons.notifications_off_outlined,
              color: Colors.grey,
            ),
    );
  }
}
