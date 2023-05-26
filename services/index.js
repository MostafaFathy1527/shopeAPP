/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.signup = functions.https.onRequest(async (req, res) => {
  try {
    const { email, password } = req.body;
    const userRecord = await admin.auth().createUser({
      email: email,
      password: password
    });
    res.status(200).json({ message: 'Signup successful', userId: userRecord.uid });
  } catch (error) {
    res.status(400).json({ message: 'Signup failed', error: error.message });
  }
});

exports.login = functions.https.onRequest(async (req, res) => {
    try {
        const { email, password } = req.body;
        const userRecord = await admin.auth().getUserByEmail(email);
        const userId = userRecord.uid;
        const token = await admin.auth().createCustomToken(userId);
        res.status(200).json({ message: 'Login successful', token: token, userId: userId });
    } catch (error) {
        res.status(400).json({ message: 'Login failed', error: error.message });
    }
}
);

exports.addUserDetails = functions.https.onRequest(async (req, res) => {
    try {
        const { userId, firstName, lastName, phoneNumber, address } = req.body;
        await admin.firestore().collection('users').doc(userId).set({
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            address: address
        });
        res.status(200).json({ message: 'User details added successfully' });
    } catch (error) {
        res.status(400).json({ message: 'User details could not be added', error: error.message });
    }
}
);

exports.getUserDetails = functions.https.onRequest(async (req, res) => {
    try {
        const { userId } = req.body;
        const userDoc = await admin.firestore().collection('users').doc(userId).get();
        const user = userDoc.data();
        res.status(200).json({ message: 'User details fetched successfully', user: user });
    } catch (error) {
        res.status(400).json({ message: 'User details could not be fetched', error: error.message });
    }
}


