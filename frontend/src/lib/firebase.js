import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";
import { getStorage } from "firebase/storage";
import { getDatabase } from "firebase/database";

// Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyDzDcc9fAQT91tNY_ADpkSWUk3livyza0",
  authDomain: "eroticlivex.firebaseapp.com",
  projectId: "eroticlivex",
  storageBucket: "eroticlivex.firebasestorage.app",
  messagingSenderId: "272346825762",
  appId: "1:272346825762:web:cd3a1d27af43df2c78367b",
  measurementId: "G-1FYHZZXQ28"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize Firebase Services
export const auth = getAuth(app);
export const db = getFirestore(app);
export const storage = getStorage(app);
export const rtdb = getDatabase(app);

export default app;
