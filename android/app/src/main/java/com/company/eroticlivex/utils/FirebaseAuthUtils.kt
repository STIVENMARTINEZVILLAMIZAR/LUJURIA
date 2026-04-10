package com.company.eroticlivex.utils

import android.util.Log
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.UserProfileChangeRequest
import kotlinx.coroutines.tasks.await

class FirebaseAuthUtils {
    companion object {
        private val auth = FirebaseAuth.getInstance()
        private const val TAG = "FirebaseAuth"

        /**
         * Registra un nuevo usuario con email y contraseña
         */
        suspend fun signUp(email: String, password: String): Result<String> = try {
            val result = auth.createUserWithEmailAndPassword(email, password).await()
            Result.success(result.user?.uid ?: "")
        } catch (e: Exception) {
            Log.e(TAG, "Error en registro: ${e.message}")
            Result.failure(e)
        }

        /**
         * Inicia sesión con email y contraseña
         */
        suspend fun signIn(email: String, password: String): Result<String> = try {
            val result = auth.signInWithEmailAndPassword(email, password).await()
            Result.success(result.user?.uid ?: "")
        } catch (e: Exception) {
            Log.e(TAG, "Error en login: ${e.message}")
            Result.failure(e)
        }

        /**
         * Cierra la sesión del usuario actual
         */
        fun signOut() {
            auth.signOut()
        }

        /**
         * Obtiene el usuario actual
         */
        fun getCurrentUser() = auth.currentUser

        /**
         * Envía un email de verificación
         */
        suspend fun sendEmailVerification(): Result<Unit> = try {
            auth.currentUser?.sendEmailVerification()?.await()
            Result.success(Unit)
        } catch (e: Exception) {
            Log.e(TAG, "Error enviando email de verificación: ${e.message}")
            Result.failure(e)
        }

        /**
         * Envía un email de recuperación de contraseña
         */
        suspend fun sendPasswordReset(email: String): Result<Unit> = try {
            auth.sendPasswordResetEmail(email).await()
            Result.success(Unit)
        } catch (e: Exception) {
            Log.e(TAG, "Error enviando email de recuperación: ${e.message}")
            Result.failure(e)
        }

        /**
         * Actualiza el perfil del usuario
         */
        suspend fun updateUserProfile(displayName: String?, photoUrl: String?): Result<Unit> = try {
            val profileUpdates = UserProfileChangeRequest.Builder()
            if (displayName != null) profileUpdates.setDisplayName(displayName)
            if (photoUrl != null) profileUpdates.setPhotoUri(android.net.Uri.parse(photoUrl))
            
            auth.currentUser?.updateProfile(profileUpdates.build())?.await()
            Result.success(Unit)
        } catch (e: Exception) {
            Log.e(TAG, "Error actualizando perfil: ${e.message}")
            Result.failure(e)
        }
    }
}
