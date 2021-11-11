import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  String _message = '';
  final _controller = TextEditingController();
  bool _isSending = false;
  Future<void> _send() async {
    setState(() {
      _isSending = true;
    });
    await FirebaseFirestore.instance
        .collection('chats/V4PSIMPKT9tLhhLnUdY4/messages')
        .add({'text': _message, 'createdAt': Timestamp.now()});
    setState(() {
      _message = '';
      _isSending = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Send Message...'),
            onChanged: (value) {
              setState(() {
                _message = value;
              });
            },
            onEditingComplete: () {
              _send();
            },
          )),
          _isSending
              ? CircularProgressIndicator()
              : IconButton(
                  onPressed: _message.trim().isEmpty ? null : _send,
                  icon: Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                )
        ],
      ),
    );
  }
}
