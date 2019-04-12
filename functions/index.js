const functions = require('firebase-functions');
const cors = require('cors')({
  origin: true
})

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.storeImage = functions.https.onRequest((req, res) => {
  return cors(req, res, () => {
    if(req.method !== 'POST'){
      return res.status(500).json({
        message: 'Not allowed'
      });
    }

    if(!req.headers.authorization || !req.headers.authorization.startsWith('Bearer ')){
      return res.status(403).json({
        error: 'Unauthorized'
      })
    }

    let idToken;
    idToken = req.headers.authorization.split('Bearer ')[1];

    
  });
});
