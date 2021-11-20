## Chat App with firebase

### Firestore rules

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
  	match /users/{uid} {
    	allow write: if request.auth!=null && request.auth.uid==uid
    }
    match /users/{uid} {
    	allow read: if request.auth!=null
    }
    match /chats/{document=**} {
      allow read, write: if request.auth!=null
    }
  }
}
```

### Steps

![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1637365488/i1tfmw5rpmjemr4sg2ys.png)

- [Initialization](https://github.com/jinyongnan810/flutter-chat/commit/bd26f1758c9fef1f0cfe7864d2aecc6d320bf58a) with firebase connection
- Basic Usage of [subscribing](https://github.com/jinyongnan810/flutter-chat/commit/5db20426d6a12b5d983463e34e60a091769da113) and [adding](https://github.com/jinyongnan810/flutter-chat/commit/8b097d9923ae4eb309d02518a1c1127fe2bef145) document form firestore
- Setting App [Theme](https://github.com/jinyongnan810/flutter-chat/commit/c5126859d9deb72c97b5f861cd093f7b7d5f7c0a)
- Auth Screen: [Markups](https://github.com/jinyongnan810/flutter-chat/commit/04286182fd75faa7588e15dfe134caa4a1e4da98), [Form](https://github.com/jinyongnan810/flutter-chat/commit/783fbf196b08bd79f7efdee267777823e0dde7e8), [Sign in](https://github.com/jinyongnan810/flutter-chat/commit/cce1355113da48bee218380b568a358b1a596ef1), [Save](https://github.com/jinyongnan810/flutter-chat/commit/4bc937a9e3a249cd25705d2a634802d3b7d30edd) to firestore([firestore rules](https://github.com/jinyongnan810/flutter-chat/commit/460cca69110be8de969998e95a3a4b631f86f222)), [Detect](https://github.com/jinyongnan810/flutter-chat/commit/e3d6eedc6c18f80d1e709e4ec5415f675c1c1602) auth changes, Select [image](https://github.com/jinyongnan810/flutter-chat/commit/4a18ef12c4c94bc74e734f043812edcbe0ed169e) and save to storage.
  ![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1637365912/fnstxrwmetifhvd3vtah.png)
- Chat Screen: [Basic](https://github.com/jinyongnan810/flutter-chat/commit/5839ce0c30e5e2f28f50725078ff610f0cea225b) send & subscribe orderly, [Styling](https://github.com/jinyongnan810/flutter-chat/commit/3c0c46b104f4d08c9566e052d1aaab8999652650), Link [firestore data](https://github.com/jinyongnan810/flutter-chat/commit/af36bc9a0571ca5fd19e37b430602e9aa34a04e3), show [icon](https://github.com/jinyongnan810/flutter-chat/commit/3aae16b48365c39768c67581bbdf51e43b78a477), [reverse](https://github.com/jinyongnan810/flutter-chat/commit/5ea67ac7273bb2591cd22291d6776870e286cd97) chat messages.
- Push Notifications: [Dependencies](https://github.com/jinyongnan810/flutter-chat/commit/def141739422b8ec2f0d85e8aa731f485058f6cb), [Handle messages](https://github.com/jinyongnan810/flutter-chat/commit/d11b818591725766e5621da0f098439d3f655068), Firestore trigger [Function setup](https://github.com/jinyongnan810/flutter-chat/commit/c42017d68a4413c94ddda02ad9c2fc31eb47a94a), send & subscribe [topic](https://github.com/jinyongnan810/flutter-chat/commit/6e40e54099411705427b20f16166f762889ad078), subscribe to [topic during login](https://github.com/jinyongnan810/flutter-chat/commit/a420258e3b19db6ab0bb6ee6e01845c2e01b482b)
- Improvements: [Splash screen](https://github.com/jinyongnan810/flutter-chat/commit/8b706cf75f4b9fe24c0a1f3dbd508013a877c159), improve [text input](https://github.com/jinyongnan810/flutter-chat/commit/923d26811c2fe4e16e38480ad1bab8d5bbba0b1c).
- Bugs: About [sending json](https://github.com/jinyongnan810/flutter-chat/commit/7800ac77e2fdd63f3c660f4d2c33c53a7d57edc0)
