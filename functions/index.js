const functions = require('firebase-functions');
const cors = require('cors')({
  origin: true
});
const Busboy = require('busboy');
const os = require('os');
const path = require('path');
const fs = require('fs'); //? File System

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

    const busboy = new Busboy({
      headers: req.headers
    });
    let uploadData;
    let oldImagePath;

    busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {
      const filePath = path.join(os.tmpdir(), filename); //! temporary storage
      uploadData = {
        filePath: filePath,
        type: mimetype,
        name: filename
      };
      file.pipe(fs.createWriteStream(filePath));
    });

    //? Updating images
    busboy.on('field', (fieldname, value) => {
      oldImagePath = decodeURIComponent(value);
    });

    busboy.on('finish', () => {
      
    });
  });
});
