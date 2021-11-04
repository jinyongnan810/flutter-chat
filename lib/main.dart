import 'package:chat/screens/auth-screen.dart';
import 'package:chat/screens/chat-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final elevatedButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        // imply that accent color is dark, so the contrast text will be white
        accentColorBrightness: Brightness.dark,
        // setting elevated button theme
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: elevatedButtonStyle),
      ),
      home: AuthScreen(),
    );
  }
}
