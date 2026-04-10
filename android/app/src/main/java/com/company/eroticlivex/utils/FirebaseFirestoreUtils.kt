package com.company.eroticlivex.utils

import android.util.Log
import com.google.firebase.firestore.FirebaseFirestore
import kotlinx.coroutines.tasks.await

data class UserData(
    val uid: String = "",
    val email: String = "",
    val displayName: String = "",
    val createdAt: Long = 0,
    val updatedAt: Long = 0
)

class FirebaseFirestoreUtils {
    companion object {
        private val db = FirebaseFirestore.getInstance()
        private const val TAG = "Firestore"
        private const val USERS_COLLECTION = "users"

        /**
         * Crea un documento de usuario
         */
        suspend fun createUserDocument(userId: String, userData: UserData): Result<Unit> = try {
            db.collection(USERS_COLLECTION)
                .document(userId)
                .set(userData.apply { 
                    userData.copy(uid = userId, createdAt = System.currentTimeMillis())
                })
                .await()
            Result.success(Unit)
        } catch (e: Exception) {
            Log.e(TAG, "Error creando documento de usuario: ${e.message}")
            Result.failure(e)
        }

        /**
         * Obtiene un documento de usuario
         */
        suspend fun getUserData(userId: String): Result<UserData> = try {
            val doc = db.collection(USERS_COLLECTION)
                .document(userId)
                .get()
                .await()
            
            val userData = doc.toObject(UserData::class.java) ?: UserData()
            Result.success(userData)
        } catch (e: Exception) {
            Log.e(TAG, "Error obteniendo documento de usuario: ${e.message}")
            Result.failure(e)
        }

        /**
         * Actualiza un documento de usuario
         */
        suspend fun updateUserData(userId: String, updates: Map<String, Any>): Result<Unit> = try {
            val dataWithTimestamp = updates.toMutableMap().apply {
                this["updatedAt"] = System.currentTimeMillis()
            }
            
            db.collection(USERS_COLLECTION)
                .document(userId)
                .update(dataWithTimestamp)
                .await()
            Result.success(Unit)
        } catch (e: Exception) {
            Log.e(TAG, "Error actualizando documento de usuario: ${e.message}")
            Result.failure(e)
        }

        /**
         * Elimina un documento de usuario
         */
        suspend fun deleteUserData(userId: String): Result<Unit> = try {
            db.collection(USERS_COLLECTION)
                .document(userId)
                .delete()
                .await()
            Result.success(Unit)
        } catch (e: Exception) {
            Log.e(TAG, "Error eliminando documento de usuario: ${e.message}")
            Result.failure(e)
        }
    }
}
