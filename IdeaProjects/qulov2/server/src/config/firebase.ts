import admin from 'firebase-admin';
import type { messaging } from 'firebase-admin';
import { env } from './env.js';

const serviceAccount = JSON.parse(env.FIREBASE_SERVICE_ACCOUNT);

let firebaseInitialized = false;

if (serviceAccount.project_id) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });
  firebaseInitialized = true;
}

export const firebaseAdmin = admin;

export function getFcm(): messaging.Messaging | null {
  if (!firebaseInitialized) return null;
  return admin.messaging();
}
