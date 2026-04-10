package com.company.eroticlivex

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.company.eroticlivex.ui.theme.EroticLiveXTheme
import com.google.firebase.Firebase
import com.google.firebase.auth.auth
import com.google.firebase.firestore.firestore

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Inicializar Firebase
        initializeFirebase()
        
        setContent {
            EroticLiveXTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    MainScreen()
                }
            }
        }
    }

    private fun initializeFirebase() {
        // Firebase está inicializado automáticamente por Google Services plugin
        val auth = Firebase.auth
        val db = Firebase.firestore
        
        // Verificar usuario actual
        val currentUser = auth.currentUser
        if (currentUser != null) {
            // Usuario autenticado
            println("Usuario autenticado: ${currentUser.email}")
        } else {
            // Usuario no autenticado
            println("Usuario no autenticado")
        }
    }
}

@Composable
fun MainScreen() {
    Text(
        text = "¡Bienvenido a EroticLiveX!",
        style = MaterialTheme.typography.headlineLarge
    )
}

@Preview(showBackground = true)
@Composable
fun MainScreenPreview() {
    EroticLiveXTheme {
        MainScreen()
    }
}
