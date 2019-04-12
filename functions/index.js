const functions = require('firebase-functions');
const cors = require('cors')({
  origin: true
});
const Busboy = require('busboy');
const os = require('os');
const path = require('path');
const fs = require('fs'); //? File System
const fbAdmin = require('firebase-admin');
const uuid = require('uuid/v4');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const gcconfig = {
  projectId: 'waste-mx',
  keyFilename: 'waste-mx-firebase-adminsdk.json'
}

const {Storage} = require('@google-cloud/storage');
const gcs = new Storage(gcconfig);

fbAdmin.initializeApp({
  credential: fbAdmin.credential.cert(require('./waste-mx-firebase-adminsdk.json'))
});

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
      const bucket = gcs.bucket('waste-mx.appspot.com'); //? Bucket is simply a folder in cloud storage
      const id = uuid();
      let imagePath = 'images/' + id + '-' + uploadData.name;
      if(oldImagePath){
        imagePath = oldImagePath;
      }

      return fbAdmin.auth().verifyIdToken(idToken).then((decodedToken) => {
        return bucket.upload(uploadData.filePath, {
          uploadType: 'media',
          destination: imagePath,
          metadata: {
            metadata: {
              contentType: uploadData.type, //? mimetype
              firebaseStorageDownloadToken: id
            }
          }
        });
      }).then(() => {
        return res.status(201).json({
          imageUrl: 'https://firebasestorage.googleapis.com/v0/b/' + bucket.name + '/o/' + encodeURIComponent(imagePath) + '?alt=media&token' + id,
          imagePath: imagePath
        });
      }).catch((error) => {
        return res.status(401).json({
          error: 'Unathorized'
        });
      });
    });
    return busboy.end(req.rawBody);
  });
});
