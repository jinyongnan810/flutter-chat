import 'package:chat/components/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          final user = FirebaseAuth.instance.currentUser;
          return ListView.builder(
            itemBuilder: (ctx, index) => Message(
                docs[index]['text'],
                docs[index]['userId'] == user!.uid,
                ValueKey(
                  docs[index].id,
                )),
            itemCount: docs.length,
          );
        });
  }
}
