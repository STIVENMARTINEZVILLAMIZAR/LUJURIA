import { auth } from "./firebase";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signOut,
  onAuthStateChanged,
  setPersistence,
  browserLocalPersistence,
} from "firebase/auth";

const TOKEN_KEY = "lujuria_firebase_token";
const SESSION_KEY = "lujuria_session";
const USER_KEY = "lujuria_user";

// Habilitar persistencia local
setPersistence(auth, browserLocalPersistence).catch((error) => {
  console.error("Error enabling persistence:", error);
});

/**
 * Registrar nuevo usuario con Firebase
 */
export async function register(email, password, displayName) {
  try {
    const userCredential = await createUserWithEmailAndPassword(
      auth,
      email,
      password
    );

    // Obtener ID token
    const token = await userCredential.user.getIdToken();

    // Guardar sesión
    const session = {
      uid: userCredential.user.uid,
      email: userCredential.user.email,
      displayName: displayName || userCredential.user.displayName,
      token: token,
      createdAt: new Date().toISOString(),
    };

    saveSession(session);
    return session;
  } catch (error) {
    throw new Error(error.message);
  }
}

/**
 * Login con email y contraseña
 */
export async function login(email, password) {
  try {
    const userCredential = await signInWithEmailAndPassword(auth, email, password);

    // Obtener ID token
    const token = await userCredential.user.getIdToken();

    const session = {
      uid: userCredential.user.uid,
      email: userCredential.user.email,
      displayName: userCredential.user.displayName,
      token: token,
      createdAt: new Date().toISOString(),
    };

    saveSession(session);
    return session;
  } catch (error) {
    throw new Error(error.message);
  }
}

/**
 * Logout
 */
export async function logout() {
  try {
    await signOut(auth);
    clearSession();
  } catch (error) {
    console.error("Logout error:", error);
    throw error;
  }
}

/**
 * Obtener token actual
 */
export async function getToken() {
  if (!auth.currentUser) return null;
  return await auth.currentUser.getIdToken();
}

/**
 * Obtener sesión guardada
 */
export function getSession() {
  const raw = localStorage.getItem(SESSION_KEY);
  return raw ? JSON.parse(raw) : null;
}

/**
 * Obtener usuario actual
 */
export function getCurrentUser() {
  return auth.currentUser;
}

/**
 * Guardar sesión
 */
export function saveSession(session) {
  localStorage.setItem(TOKEN_KEY, session.token);
  localStorage.setItem(SESSION_KEY, JSON.stringify(session));
  localStorage.setItem(USER_KEY, JSON.stringify({
    uid: session.uid,
    email: session.email,
    displayName: session.displayName,
  }));
}

/**
 * Limpiar sesión
 */
export function clearSession() {
  localStorage.removeItem(TOKEN_KEY);
  localStorage.removeItem(SESSION_KEY);
  localStorage.removeItem(USER_KEY);
}

/**
 * Listener para cambios de autenticación
 */
export function onAuthChange(callback) {
  return onAuthStateChanged(auth, (user) => {
    if (user) {
      user.getIdToken().then((token) => {
        const session = {
          uid: user.uid,
          email: user.email,
          displayName: user.displayName,
          token: token,
        };
        saveSession(session);
        callback(user);
      });
    } else {
      clearSession();
      callback(null);
    }
  });
}
