const functions = require('firebase-functions');
const cors = require('cors');
const { firestore } = require('firebase-admin');

// Import and initialize the Firebase Admin SDK
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();



// Enable CORS for all routes
const corsMiddleware = cors({ origin: true });


// Import function triggers from their respective submodules
const { onRequest } = require("firebase-functions/v2/https");
const { onDocumentWritten } = require("firebase-functions/v2/firestore");

const logger = require("firebase-functions/logger");
const express = require('express');
const app = express();
app.use(cors());
app.post('/signup', async (req, res) => {
  try {
    const { email, password, name } = req.body;

    // Perform signup logic using Firebase Authentication
    const userRecord = await admin.auth().createUser({
      email,
      password,
      displayName: name
    });

    // Save user data to Firestore
    await db.collection('users').doc(userRecord.uid).set({
      email,
      name
    });

    res.json({ message: 'Signup successful' });
  } catch (error) {
    console.error('Signup error:', error);
    res.status(500).json({ error: 'Signup failed' });
  }
});


exports.signup = functions.https.onRequest(async (req, res) => {
  corsMiddleware(req, res, async () => {

  try {
    const { email, password, name } = req.body;

    // Perform signup logic using Firebase Authentication
    const userRecord = await admin.auth().createUser({
      email,
      password,
      displayName: name
    });

    // Save user data to Firestore
    await db.collection('users').doc(userRecord.uid).set({
      email,
      name
    });

    res.json({ message: 'Signup successful' });
  } catch (error) {
    console.error('Signup error:', error);
    res.status(500).json({ error: 'Signup failed' });
  }
  });
});

exports.login = functions.https.onRequest(async (req, res) => {
  corsMiddleware(req, res, async () => {

  try {
    const { email, password } = req.body;

    // Perform login logic using Firebase Authentication
    await admin.auth().signInWithEmailAndPassword(email, password);

    res.json({ message: 'Login successful' });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Login failed' });
  }
  });
});

exports.googleSignIn = functions.https.onRequest(async (req, res) => {
  corsMiddleware(req, res, async () => {

  try {
    const { idToken } = req.body;

    // Perform Google Sign-In logic using Firebase Authentication
    const credential = admin.auth.GoogleAuthProvider.credential(idToken);
    await admin.auth().signInWithCredential(credential);

    res.json({ message: 'Google sign-in successful' });
  } catch (error) {
    console.error('Google sign-in error:', error);
    res.status(500).json({ error: 'Google sign-in failed' });
  }
  });
});

exports.signout = functions.https.onRequest(async (req, res) => {
  corsMiddleware(req, res, async () => {
    try {
      const { idToken } = req.body;

      await admin.auth().revokeRefreshTokens(idToken);

      res.json({ message: 'Sign-out successful' });
    } catch (error) {
      console.error('Sign-out error:', error);
      res.status(500).json({ error: 'Sign-out failed', message: error.message });
    }
  });
});
// Define onRequest trigger
exports.getCategories = functions.region('us-central1').https.onRequest(async (req, res) => {
  try {
    const categoriesSnapshot = await db.collection('Catagories').get();
    const categories = categoriesSnapshot.docs.map(doc => doc.data());
    res.set('Access-Control-Allow-Origin', '*'); // Set CORS header
    res.json(categories);
  } catch (error) {
    console.error('Error getting categories:', error);
    res.status(500).send('Internal server error');
  }
});

// Define onDocumentWritten trigger
exports.onProductWritten = functions.region('us-central1').firestore.document('Products/{productId}').onWrite(async (change, context) => {
  // Handle document write event here
});

// Example usage in the onRequest function
exports.getBestSellingProducts = functions.region('us-central1').https.onRequest(async (req, res) => {
  try {
    const productsSnapshot = await db.collection('Products').get();
    const products = productsSnapshot.docs.map(doc => doc.data());
    res.set('Access-Control-Allow-Origin', '*'); // Set CORS header
    res.json(products);
  } catch (error) {
    console.error('Error getting best-selling products:', error);
    res.status(500).send('Internal server error');
  }
});


// Export the Express app as a Cloud Function
exports.api = functions.region('us-central1').https.onRequest(app);
