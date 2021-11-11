import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  Message(this.msg, this.isMe, this.key);
  String msg;
  bool isMe;
  Key key;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          child: Text(
            msg,
            style: TextStyle(
                color: Theme.of(context).accentTextTheme.headline1!.color),
          ),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
              color: isMe ? Colors.green[700] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: isMe ? Radius.circular(8) : Radius.zero,
                bottomRight: !isMe ? Radius.circular(8) : Radius.zero,
              )),
        )
      ],
    );
  }
}
