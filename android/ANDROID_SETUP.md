# Proyecto Android con Firebase - Guía de Configuración

## 📱 Descripción

Este es el proyecto Android nativo para **EroticLiveX**, integrado completamente con Firebase para:
- ✅ Autenticación de usuarios
- ✅ Almacenamiento de datos en tiempo real (Firestore)
- ✅ Almacenamiento de archivos (Storage)
- ✅ Notificaciones push (Cloud Messaging)
- ✅ Analytics

## 📂 Estructura del Proyecto

```
android/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── AndroidManifest.xml
│   │   │   ├── java/com/company/eroticlivex/
│   │   │   │   ├── MainActivity.kt            # Actividad principal
│   │   │   │   ├── firebase/
│   │   │   │   │   └── MyFirebaseMessagingService.kt
│   │   │   │   └── utils/
│   │   │   │       ├── FirebaseAuthUtils.kt   # Utilidades de autenticación
│   │   │   │       └── FirebaseFirestoreUtils.kt
│   │   │   └── res/
│   │   │       ├── layout/
│   │   │       ├── values/
│   │   │       └── drawable/
│   │   └── test/
│   ├── build.gradle.kts
│   ├── google-services.json        # ⚠️ CRÍTICO
│   └── proguard-rules.pro
├── build.gradle.kts
├── settings.gradle.kts
└── gradle.properties
```

## 🔧 Requisitos Previos

- Android Studio 2023.1 o superior
- JDK 17 o superior
- Android SDK 34 (API 34)
- Emulador de Android o dispositivo físico (Android 7.0+)

## ⚙️ Instrucciones de Instalación

### 1. Clonar/Descargar el Proyecto

```bash
cd path/to/EroticLiveX
cd android
```

### 2. Sincronizar Gradle

Abre el proyecto en Android Studio:
```bash
android studio .
```

Android Studio automáticamente sincronizará las dependencias de Gradle.

### 3. Verificar Configuración de Firebase

✅ El archivo `google-services.json` ya está en la carpeta `app/` con la configuración correcta:
- **Project ID:** eroticlivex
- **Package Name:** com.company.eroticlivex
- **Storage Bucket:** eroticlivex.firebasestorage.app

### 4. Construir el Proyecto

```bash
# Compilar
./gradlew build

# Ejecutar en emulador/dispositivo
./gradlew installDebug
```

## 🔐 Funcionalidades Firebase

### Autenticación (Firebase Auth)

```kotlin
// Registrarse
FirebaseAuthUtils.signUp("user@example.com", "password123")

// Iniciar sesión
FirebaseAuthUtils.signIn("user@example.com", "password123")

// Obtener usuario actual
val user = FirebaseAuthUtils.getCurrentUser()

// Cerrar sesión
FirebaseAuthUtils.signOut()
```

### Base de Datos (Firestore)

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
    "displayName" to "Jane Doe"
))
```

### Notificaciones Push (FCM)

Las notificaciones se manejan automáticamente mediante `MyFirebaseMessagingService.kt`.

## 📦 Dependencias Principales

| Dependencia | Versión | Propósito |
|-------------|---------|-----------|
| Firebase BOM | 32.7.0 | Gestión centralizada de versiones |
| Firebase Auth | Latest | Autenticación de usuarios |
| Firebase Firestore | Latest | Base de datos en tiempo real |
| Firebase Storage | Latest | Almacenamiento de archivos |
| Firebase Messaging | Latest | Notificaciones push |
| Jetpack Compose | 1.6.1 | UI moderna |
| Kotlin Coroutines | Latest | Programación asincrónica |
| Retrofit 2 | 2.10.0 | Cliente HTTP |
| GSON | 2.10.1 | Serialización JSON |

## 🚀 Compilación y Despliegue

### Debug

```bash
./gradlew installDebug
```

### Release

```bash
# Generar APK signed
./gradlew assembleRelease

# Generar App Bundle
./gradlew bundleRelease
```

## 📱 Emulador Android

Para ejecutar en emulador:

```bash
# Iniciar emulador (si no está corriendo)
emulator -avd Pixel_4_API_34 &

# Esperar a que esté listo
adb wait-for-device

# Instalar app
./gradlew installDebug

# Ejecutar
adb shell am start -n com.company.eroticlivex/.MainActivity
```

## 🔗 Integración con Backend

El backend está disponible en:
- **URL Local:** http://localhost:8080
- **URL Producción:** (a configurar)

Utiliza `Retrofit` para comunicación HTTP con el backend.

## 📝 Configuración de Firebase

1. **Cloud Firestore:**
   - Colección: `users` - Datos de usuarios
   - Reglas de seguridad: Configurar en Firebase Console

2. **Authentication:**
   - Métodos habilitados: Email/Password, Google Sign-In, Phone

3. **Cloud Storage:**
   - Bucket: `eroticlivex.firebasestorage.app`
   - Para imágenes de perfil, streams, contenido

4. **Cloud Messaging:**
   - Envío de notificaciones push a usuarios
   - Tópicos: `announcements`, `promotions`, `messages`

## 🛡️ Seguridad

### Permisos en AndroidManifest.xml

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

### Reglas de Firestore

```
match /databases/{database}/documents {
    match /users/{userId} {
        allow read, write: if request.auth.uid == userId;
    }
}
```

## 🧪 Testing

Ejecutar tests unitarios:
```bash
./gradlew test
```

Ejecutar tests instrumentados (en dispositivo/emulador):
```bash
./gradlew connectedAndroidTest
```

## 📚 Documentación Adicional

- [Firebase Documentation](https://firebase.google.com/docs)
- [Android Developers](https://developer.android.com)
- [Jetpack Compose](https://developer.android.com/jetpack/compose)
- [Kotlin Coroutines](https://kotlinlang.org/docs/coroutines-overview.html)

## 🐛 Solución de Problemas

### Error: "google-services.json not found"
- Verifica que `google-services.json` está en `app/` (no en `android/app/src/`)
- Reconstruye el proyecto: `./gradlew clean build`

### Error: "FirebaseApp with name [DEFAULT] doesn't exist"
- Asegúrate de que Firebase está inicializado automáticamente
- Verifica que el plugin de Google Services está aplicado en `build.gradle.kts`

### Error: "Permission denied" en Firestore
- Revisa las reglas de seguridad en Firebase Console
- Verifica que el usuario está autenticado

## 👥 Contribución

Para cambios principales:
1. Crea una rama: `git checkout -b feature/mi-feature`
2. Commit: `git commit -m "Agregar mi feature"`
3. Push: `git push origin feature/mi-feature`
4. Abre un Pull Request

## 📄 Licencia

Este proyecto es parte de EroticLiveX - Todos los derechos reservados.
