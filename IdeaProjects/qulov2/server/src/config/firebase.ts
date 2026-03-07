import admin from 'firebase-admin';
import type { messaging } from 'firebase-admin';
import { env } from './env.js';

const serviceAccount = JSON.parse(env.FIREBASE_SERVICE_ACCOUNT);

if (serviceAccount.project_id) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });
}

export const firebaseAdmin = admin;
export const fcm: messaging.Messaging = admin.messaging();
