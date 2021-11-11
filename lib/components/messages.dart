import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/V4PSIMPKT9tLhhLnUdY4/messages')
            .orderBy('createdAt')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = streamSnapshot.data!.docs;
          return ListView.builder(
            itemBuilder: (ctx, index) =>
                ListTile(title: Text(docs[index]['text'])),
            itemCount: docs.length,
          );
        });
  }
}
