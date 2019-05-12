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
const axios = require('axios');

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
              firebaseStorageDownloadTokens: id
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

exports.fetchClosestVendors = functions.https.onRequest((req, res) => {
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
    
    // let clientPos = JSON.parse(req.body['pos']);
    let clientPos = req.body['pos'];

    function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
      var R = 6371; // Radius of the earth in km
      var dLat = deg2rad(lat2-lat1);  // deg2rad below
      var dLon = deg2rad(lon2-lon1); 
      var a = 
        Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
        Math.sin(dLon/2) * Math.sin(dLon/2)
        ; 
      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
      var d = R * c; // Distance in km
      return d;
    }
    
    function deg2rad(deg) {
      return deg * (Math.PI/180)
    }

    function compareDist(vendor1, vendor2){
      return getDistanceFromLatLonInKm(vendor1['pos'][0], vendor1['pos'][1], clientPos[0], clientPos[1]) < getDistanceFromLatLonInKm(vendor2['pos'][0], vendor2['pos'][1], clientPos[0], clientPos[1]) ? 1 : -1;
    }

    let idToken = req.headers.authorization.split('Bearer ')[1];

    // return res.status(201).json({
    //   'pos': req.body['pos']
    // });

    return fbAdmin.auth().verifyIdToken(idToken).then(() => {
      // let db = fbAdmin.database();
      // db.ref('vendors').on("value", (snapshot) => {
      //   vendors = snapshot.val();
        
      //   let closestVendors = [];
      //   // vendors.forEach((vendor, index, vendors) => {
      //   //   if(getDistanceFromLatLonInKm(vendor['pos'][0], vendor['pos'][1], clientPos[0], clientPos[1]) < 10){
      //   //     closestVendors.push(vendor);
      //   //   }
      //   // });
      //   // closestVendors = vendors.sort((vendor1, vendor2) => compareDist(vendor1, vendor2));

      //   // return res.status(201).json(vendors);
      // });
      axios.get('https://waste-mx.firebaseio.com/vendors.json').then((resp) => {
        let vendorObjs = resp.data;
        let vendors = [];
        let closestVendors = [];
        for(id in vendorObjs){
          let vendorObj = vendorObjs[id];
          vendorObj['id'] = id;
          vendors.push(vendorObj);
        }

        closestVendors = vendors.sort((vendor1, vendor2) => compareDist(vendor1, vendor2));
        closestVendorObjs = {};
        closestVendors.forEach((closestVendor) => {
          let id =  closestVendor['id']
          delete closestVendor['id']
          closestVendorObjs['id'] = closestVendor;
        });
        return res.status(201).json({'data': closestVendorObjs});
      });
    }).catch((error) => {
      console.log(error);
      return res.status(401).json({
        error: 'Unathorized'
      });
    });
  });
});
