import 'package:chat/get-user-from-firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  Message(this.msg, this.uid, this.isMe, this.key);
  String msg;
  String uid;
  bool isMe;
  Key key;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: FutureBuilder(
                  future: UserFromFirestore.getUserName(uid),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        'Loading...',
                        style: TextStyle(color: Colors.grey),
                      );
                    }
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(
                          color: isMe
                              ? Colors.green[700]
                              : Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold),
                    );
                  }),
            ),
            Container(
              child: Text(
                msg,
                style: TextStyle(
                    color: Theme.of(context).accentTextTheme.headline1!.color),
              ),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 100),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color:
                      isMe ? Colors.green[700] : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: isMe ? Radius.circular(8) : Radius.zero,
                    bottomRight: !isMe ? Radius.circular(8) : Radius.zero,
                  )),
            ),
          ],
        )
      ],
    );
  }
}
