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

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const moment = require("moment");

admin.initializeApp();
const db = admin.firestore();
const messaging = admin.messaging();

/// 🕒 Start Flash Sale - Runs Daily at 6 PM
exports.startFlashSale = functions.pubsub.schedule("0 18 * * *").timeZone("America/New_York").onRun(async (context) => {
    const flashSaleEndTime = moment().add(30, "minutes").toDate();

    // Activate Flash Sale in Firestore
    await db.collection("flash_sale").doc("status").set({
        isActive: true,
        endsAt: flashSaleEndTime,
    });

    // Update products to be on Flash Sale
    const productsSnapshot = await db.collection("products").get();
    productsSnapshot.forEach(async (doc) => {
        await doc.ref.update({ isFlashSale: true });
    });

    console.log("🔥 Flash Sale Started!");

    // Send Notification
    const payload = {
        notification: {
            title: "🔥 Flash Sale is Live!",
            body: "Get up to 50% off for the next 30 minutes!",
        },
        topic: "flash_sale",
    };

    await messaging.send(payload);
    console.log("🔔 Flash Sale Notification Sent!");

    return null;
});

/// ⏳ End Flash Sale - Runs at 6:30 PM
exports.endFlashSale = functions.pubsub.schedule("30 18 * * *").timeZone("America/New_York").onRun(async (context) => {
    // Deactivate Flash Sale in Firestore
    await db.collection("flash_sale").doc("status").set({
        isActive: false,
    });

    // Remove flash sale from products
    const productsSnapshot = await db.collection("products").get();
    productsSnapshot.forEach(async (doc) => {
        await doc.ref.update({ isFlashSale: false });
    });

    console.log("⏳ Flash Sale Ended!");
    return null;
});



// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
