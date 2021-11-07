import 'package:chat/components/auth-form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Authenticate Error'),
              content: Text(msg),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(ctx).pop(), child: Text('OK'))
              ],
            ));
  }

  Future<void> _submitForm(
      String email, String username, String password, bool isLogin) async {
    try {
      if (isLogin) {
        final authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        authResult.user;
      } else {
        final authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({username: username, email: email});
      }
    } on FirebaseAuthException catch (error) {
      _showErrorDialog(
          'Error: ${error.message ?? "Please check your credentials."}');
    } catch (error) {
      print('Un expected error: ${error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitForm),
    );
  }
}
