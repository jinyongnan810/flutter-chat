import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/V4PSIMPKT9tLhhLnUdY4/messages')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemBuilder: (ctx, index) =>
                ListTile(title: Text(streamSnapshot.data!.docs[index]['text'])),
            itemCount: streamSnapshot.data!.docs.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
