# 📱 Integración de Android + Firebase - EroticLiveX

Esta es la documentación principal de la integración entre el proyecto Android nativo y Firebase.

## 📋 Contenido

1. **Backend Java/Spring Boot** (`../`)
   - API REST
   - Gestión de usuarios
   - Lógica de negocio

2. **Frontend React** (`../frontend/`)
   - Web app
   - Dashboard
   - Funcionalidades web

3. **Android App** (`./`)
   - App nativa para Android
   - Integración con Firebase
   - Autenticación y notificaciones

---

## 🔗 Arquitectura General

```
┌─────────────────────────────────────────────────────┐
│                   Firebase Console                  │
│  (Autenticación, Firestore, Storage, Messaging)    │
└──────┬──────────────────────────────────────────────┘
       │
       ├─────────────────┬──────────────────┬───────────────┐
       │                 │                  │               │
   ┌───▼───┐         ┌───▼───┐         ┌──▼────┐      ┌───▼────┐
   │Android│         │Frontend│         │Backend│      │Storage │
   │  App  │         │(React) │         │(Java) │      │(Cloud) │
   └───────┘         └────────┘         └───────┘      └────────┘
```

---

## 🚀 Inicio Rápido - Android

### 1. Clonar el Proyecto
```bash
git clone <repository-url>
cd EroticLiveX/android
```

### 2. Abrir en Android Studio
```bash
android-studio .
```

### 3. Sincronizar Gradle
Android Studio automáticamente sincronizará todas las dependencias al abrir el proyecto.

### 4. Ejecutar la App
```bash
# En emulador o dispositivo conectado
./gradlew installDebug
```

---

## 🔐 Firebase - Configuración

### Archivo: `app/google-services.json`

✅ **Ya está configurado** con credenciales de Firebase:
```json
{
  "project_id": "eroticlivex",
  "storage_bucket": "eroticlivex.firebasestorage.app",
  "api_key": "AIzaSyB8kPEC64SjbdxRdYJUFAUbZ0Dv53I_l5Y"
}
```

### Servicios Habilitados

| Servicio | Estado | Uso |
|----------|--------|-----|
| Authentication | ✅ Habilitado | Email/Password, Google Sign-In |
| Cloud Firestore | ✅ Habilitado | Base de datos de usuarios/contenido |
| Cloud Storage | ✅ Habilitado | Imágenes, videos, perfiles |
| Cloud Messaging | ✅ Habilitado | Notificaciones push |
| Analytics | ✅ Habilitado | Seguimiento de eventos |

---

## 📱 Funcionalidades Android

### 1. Autenticación

Usar `FirebaseAuthUtils.kt`:

```kotlin
// Registrarse
FirebaseAuthUtils.signUp("email@example.com", "password")

// Iniciar sesión
FirebaseAuthUtils.signIn("email@example.com", "password")

// Obtener usuario actual
val user = FirebaseAuthUtils.getCurrentUser()

// Enviar verificación de email
FirebaseAuthUtils.sendEmailVerification()

// Recuperar contraseña
FirebaseAuthUtils.sendPasswordReset("email@example.com")
```

### 2. Base de Datos

Usar `FirebaseFirestoreUtils.kt`:

```kotlin
// Crear usuario
val userData = UserData(
    email = "user@example.com",
    displayName = "John Doe"
)
FirebaseFirestoreUtils.createUserDocument(userId, userData)

// Obtener datos
val result = FirebaseFirestoreUtils.getUserData(userId)

// Actualizar datos
FirebaseFirestoreUtils.updateUserData(userId, mapOf(
    "displayName" to "Jane Doe",
    "bio" to "Nueva biografía"
))

// Eliminar datos
FirebaseFirestoreUtils.deleteUserData(userId)
```

### 3. Notificaciones Push

Automáticamente manejadas por `MyFirebaseMessagingService.kt`:

```kotlin
class MyFirebaseMessagingService : FirebaseMessagingService() {
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        // Procesar notificación recibida
    }
    
    override fun onNewToken(token: String) {
        // Token refresh - enviar al servidor
    }
}
```

### 4. UI con Jetpack Compose

La app utiliza **Jetpack Compose** para UI moderna:

```kotlin
@Composable
fun MainScreen() {
    Text("¡Bienvenido a EroticLiveX!")
}
```

---

## 🗂️ Estructura de Carpetas

```
android/
│
├── app/
│   ├── src/main/
│   │   ├── AndroidManifest.xml              # Declaración de permisos y componentes
│   │   ├── java/com/company/eroticlivex/
│   │   │   ├── MainActivity.kt              # Actividad principal
│   │   │   ├── firebase/
│   │   │   │   └── MyFirebaseMessagingService.kt
│   │   │   ├── utils/
│   │   │   │   ├── FirebaseAuthUtils.kt     # 🔐 Autenticación
│   │   │   │   └── FirebaseFirestoreUtils.kt # 💾 Base de datos
│   │   │   └── ui/theme/
│   │   │       └── Theme.kt                 # Estilos de UI
│   │   └── res/
│   │       ├── layout/                      # Layouts XML (si los hay)
│   │       ├── values/                      # Dimensiones, colores, strings
│   │       ├── drawable/                    # Recursos gráficos
│   │       └── xml/                         # Configuraciones XML
│   ├── build.gradle.kts                     # ⚙️ Configuración compilación
│   ├── google-services.json                 # 🔑 Credenciales Firebase
│   └── proguard-rules.pro                   # Reglas ofuscación
│
├── build.gradle.kts                         # Configuración raíz
├── settings.gradle.kts                      # Módulos del proyecto
├── gradle.properties                        # Propiedades Gradle
├── ANDROID_SETUP.md                         # Guía detallada
├── QUICK_START.md                           # Inicio rápido
└── gradlew / gradlew.bat                    # Wrapper de Gradle
```

---

## 🔧 Compilación

### Compilación Debug
```bash
./gradlew build
./gradlew installDebug
```

### Compilación Release
```bash
# Generar APK signed
./gradlew assembleRelease

# Generar App Bundle (para Google Play)
./gradlew bundleRelease
```

### Limpiar Cache
```bash
./gradlew clean
```

---

## 📊 Dependencias Principales

| Dependencia | Versión | Propósito |
|-------------|---------|-----------|
| **Firebase BOM** | 32.7.0 | Gestión de versiones de Firebase |
| **Android Gradle Plugin** | 8.2.0 | Compilación Android |
| **Kotlin** | 1.9.20 | Lenguaje de programación |
| **Jetpack Compose** | 1.6.1 | UI declarativo |
| **AndroidX** | Latest | Bibliotecas de soporte |
| **Firebase Auth** | Latest | Autenticación |
| **Firebase Firestore** | Latest | Base de datos NoSQL |
| **Firebase Storage** | Latest | Almacenamiento de archivos |
| **Firebase Messaging** | Latest | Notificaciones push |
| **Retrofit** | 2.10.0 | Cliente HTTP |
| **Coil** | 2.6.0 | Carga de imágenes |

---

## 🛡️ Seguridad

### Permisos en AndroidManifest.xml

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

### Reglas de Firestore

```javascript
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    // Solo el propietario puede leer/escribir sus datos
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }
    
    // Contenido público (solo lectura)
    match /streams/{document=**} {
      allow read: if true;
      allow write: if request.auth.uid != null;
    }
  }
}
```

---

## 🧪 Testing

### Tests Unitarios
```bash
./gradlew test
```

### Tests Instrumentados
```bash
./gradlew connectedAndroidTest
```

---

## 📡 Integración Backend

### Conectar a Backend Local
```kotlin
// En Retrofit
val baseUrl = "http://10.0.2.2:8080"  // Para emulador
// o "http://localhost:8080"  // Para dispositivo físico
```

### Endpoints Esperados
- `POST /api/auth/login` - Autenticación
- `GET /api/users/{id}` - Obtener usuario
- `POST /api/users` - Crear usuario
- `PUT /api/users/{id}` - Actualizar usuario

---

## 🚀 Despliegue en Google Play Store

1. **Generar signed APK/Bundle:**
   ```bash
   ./gradlew bundleRelease
   ```

2. **Crear cuenta en Google Play Developer:**
   https://play.google.com/console

3. **Subir App Bundle a Google Play:**
   - Console → Tu app → Release → Production
   - Sube el archivo `.aab`

4. **Completar información de la tienda:**
   - Screenshots
   - Descripción
   - Política de privacidad (IMPORTANTE)

---

## 📚 Documentación Externa

- [Firebase Documentation](https://firebase.google.com/docs)
- [Android Developers Guide](https://developer.android.com/docs)
- [Jetpack Compose](https://developer.android.com/jetpack/compose)
- [Kotlin Official Docs](https://kotlinlang.org/docs)
- [Google Play Store Policies](https://play.google.com/about/developer-content-policy/)

---

## 🐛 Troubleshooting

### "google-services.json not found"
✅ Solución: Verifica que está en `app/google-services.json` (no en raíz)

### "FirebaseApp doesn't exist"
✅ Solución: Asegúrate que el plugin `com.google.gms.google-services` está en `build.gradle.kts`

### "Permission denied" en Firestore
✅ Solución: Revisa las reglas de seguridad en Firebase Console

### Build lento en emulador
✅ Solución: Incrementa RAM del emulador (Settings → RAM: 4GB+)

---

## 👥 Team

| Rol | Responsabilidad |
|-----|-----------------|
| Backend | Java/Spring Boot - API REST |
| Frontend | React - Dashboard web |
| Mobile | Kotlin - App Android |
| DevOps | Despliegue y CI/CD |

---

## 📄 Licencia

Parte del proyecto **EroticLiveX** - Todos los derechos reservados.

---

**Última actualización:** 2026-04-09  
**Versión Android:** 1.0.0
