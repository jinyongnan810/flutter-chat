const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const msg = admin.messaging();
const fs = admin.firestore();

exports.sendNotifications = functions.firestore
    .document("chats/V4PSIMPKT9tLhhLnUdY4/messages/{message}")
    .onCreate(async (change, context) => {
      const data = change.data();
      const userSnapshot = await fs.doc(`users/${data.userId}`).get();
      const user = userSnapshot.data();
      return msg.sendToTopic("chats-V4PSIMPKT9tLhhLnUdY4", {
        notification: {
          title: user.username,
          body: data.text,
          icon: user.image,
        },
      });
    });
