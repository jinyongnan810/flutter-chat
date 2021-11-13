import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  String username;
  String email;
  UserInfo(this.username, this.email);
}

class UserFromFirestore {
  static Map<String, UserInfo> users = {};
  static Future<String> getUserName(String uid) async {
    if (users.containsKey(uid)) {
      print('get from cache');
      return users[uid]!.username;
    }
    final user =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print('get from firestore');
    String username;
    String email;
    if (user.exists) {
      username = user['username'];
      email = user['email'];
    } else {
      username = 'User Deleted';
      email = 'User Deleted';
    }
    users[uid] = UserInfo(username, email);
    return username;
  }
}
