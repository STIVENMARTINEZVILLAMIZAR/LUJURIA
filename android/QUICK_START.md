# Quick Start - Android Firebase

## 🚀 Inicio Rápido

### Paso 1: Instala Android Studio
Descarga desde: https://developer.android.com/studio

### Paso 2: Abre el Proyecto
```bash
cd android
android-studio .
```

### Paso 3: Espera a que Gradle se Sincronice
Android Studio instalará automáticamente todas las dependencias.

### Paso 4: Crea un Emulador (opcional)
- En Android Studio: Tools → Device Manager
- Crea un emulador con Android 14 (API 34)

### Paso 5: Ejecuta la App
```bash
./gradlew installDebug
```

O en Android Studio: Run → Run 'app'

---

## 📦 Archivo google-services.json

✅ **Ya está configurado** con:
- Firebase Project ID: `eroticlivex`
- Package: `com.company.eroticlivex`
- API Key: `AIzaSyB8kPEC64SjbdxRdYJUFAUbZ0Dv53I_l5Y`

⚠️ **IMPORTANTE:** No compartas la API Key públicamente. Úsala solo en desarrollo.

---

## 🔑 Autenticación Firebase

### Registrar Usuario
```kotlin
FirebaseAuthUtils.signUp("usuario@ejemplo.com", "contraseña")
```

### Iniciar Sesión
```kotlin
FirebaseAuthUtils.signIn("usuario@ejemplo.com", "contraseña")
```

### Cierre de Sesión
```kotlin
FirebaseAuthUtils.signOut()
```

---

## 💾 Base de Datos Firestore

### Crear Usuario
```kotlin
val user = UserData(
    email = "usuario@ejemplo.com",
    displayName = "Mi Nombre"
)
FirebaseFirestoreUtils.createUserDocument(userId, user)
```

### Leer Datos
```kotlin
val resultado = FirebaseFirestoreUtils.getUserData(userId)
```

---

## 📱 Notificaciones Push

Las notificaciones se envían automáticamente desde Firebase Console:
1. Ve a Firebase Console → Cloud Messaging
2. Selecciona tu proyecto
3. Envía notificaciones a tu app

---

## 🛠️ Comandos Útiles

```bash
# Limpiar y reconstruir
./gradlew clean build

# Ejecutar app en debug
./gradlew installDebug

# Ejecutar tests
./gradlew test

# Ver dependencias
./gradlew dependencies
```

---

## 📞 Contacto

Para soporte o preguntas sobre Firebase, consulta:
- [Firebase Docs](https://firebase.google.com/docs)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/firebase)
