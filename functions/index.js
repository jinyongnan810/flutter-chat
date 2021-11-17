const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.sendNotifications = functions.firestore
    .document("chats/V4PSIMPKT9tLhhLnUdY4/messages/{message}")
    .onCreate((change, context) => {
      console.log(change.data());
      return;
    });
