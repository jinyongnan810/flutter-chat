import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  String username;
  String email;
  String image;
  UserInfo(this.username, this.email, this.image);
}

class UserFromFirestore {
  static Map<String, UserInfo> users = {};
  static Future<UserInfo> getUserInfo(String uid) async {
    if (users.containsKey(uid)) {
      print('get from cache');
      return users[uid]!;
    }
    final user =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print('get from firestore');
    String username;
    String email;
    String image;
    if (user.exists) {
      username = user['username'];
      email = user['email'];
      image = user['image'];
    } else {
      username = 'User Deleted';
      email = 'User Deleted';
      image = '';
    }
    users[uid] = UserInfo(username, email, image);
    return users[uid]!;
  }
}
