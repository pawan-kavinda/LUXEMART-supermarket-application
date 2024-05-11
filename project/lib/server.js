const admin = require('firebase-admin');

// Initialize Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccountKey.json), // Replace with your service account key
  databaseURL: 'YOUR_DATABASE_URL'
});

// Function to send a push notification
function sendPushNotification() {
  const message = {
    data: {
      title: 'Your notification title',
      body: 'Your notification body',
      latitude: '6.053519',
      longitude: '80.220978'
    },
    token: 'DEVICE_TOKEN' // Replace with the device token of your Flutter app
  };

  admin.messaging().send(message)
    .then((response) => {
      console.log('Successfully sent message:', response);
    })
    .catch((error) => {
      console.error('Error sending message:', error);
    });
}

// Send a push notification every 24 hours
setInterval(sendPushNotification, 24 * 60 * 60 * 1000);
