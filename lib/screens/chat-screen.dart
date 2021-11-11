import 'package:chat/components/message_input.dart';
import 'package:chat/components/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Log Out')
                  ],
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemId) {
              if (itemId == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: Messages()), MessageInput()],
        ),
      ),
    );
  }
}
