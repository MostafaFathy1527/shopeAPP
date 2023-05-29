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
const db = admin.firestore();



exports.getCategories = functions.https.onRequest(async (req, res) => {
  try {
    const categoriesSnapshot = await db.collection('Catagories').get();
    const categories = categoriesSnapshot.docs.map(doc => doc.data());
    res.json(categories);
  } catch (error) {
    console.error('Error getting categories:', error);
    res.status(500).send('Internal server error');
  }
});

// Example usage in the getBestSellingProducts function
exports.getBestSellingProducts = functions.https.onRequest(async (req, res) => {
  try {
    const productsSnapshot = await db.collection('Products').get();
    const products = productsSnapshot.docs.map(doc => doc.data());
    res.json(products);
  } catch (error) {
    console.error('Error getting best-selling products:', error);
    res.status(500).send('Internal server error');
  }
});