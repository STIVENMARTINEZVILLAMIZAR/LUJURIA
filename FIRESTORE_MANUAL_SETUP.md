# 🔥 Crear Base de Datos en Firestore - Paso a Paso

## 📍 Ubicación en Firebase Console

### Paso 1: Ingresa a Firestore

1. Ve a **Firebase Console**: https://console.firebase.google.com/
2. Selecciona el proyecto **"eroticlivex"**
3. En el menú izquierdo, busca **"Firestore Database"** bajo "Bases de datos y almacenamiento"
4. Haz clic en **"Firestore Database"**

---

## 🗂️ Crear cada Colección

### COLECCIÓN 1: usuarios

#### Paso 1: Crear colección
1. Haz clic en **"+ Crear colección"** (botón azul)
2. **Nombre de colección:** `users`
3. Haz clic en **"Siguiente"**

#### Paso 2: Agregar documento de prueba
1. **ID del documento:** Dejar en blanco (Firebase genera automáticamente) o escribe `user_demo_001`
2. Haz clic en **"Guardar"** (sin agregar campos aún)

#### Paso 3: Agregar campos
En la pantalla del documento, haz clic en **"+ Agregar campo"** para cada uno:

| Campo | Tipo | Valor |
|-------|------|-------|
| uid | String | `user_demo_001` |
| email | String | `demo@eroticlivex.com` |
| displayName | String | `María Demo` |
| isCreator | Boolean | `true` |
| isVerified | Boolean | `true` |
| rating | Number | `4.8` |
| followers | Number | `1250` |
| createdAt | Timestamp | (seleccionar fecha actual) |

✅ **Resultado esperado:** Deberías ver la colección `users` en el panel izquierdo

---

### COLECCIÓN 2: streams

#### Paso 1: Crear colección
1. Haz clic en **"+ Crear colección"** (nuevamente, en la raíz)
2. **Nombre de colección:** `streams`
3. Haz clic en **"Siguiente"**

#### Paso 2: Agregar documento
1. **ID del documento:** `stream_demo_001` (o auto)
2. Haz clic en **"Guardar"**

#### Paso 3: Agregar campos
| Campo | Tipo | Valor |
|-------|------|-------|
| streamId | String | `stream_demo_001` |
| creatorId | String | `user_demo_001` |
| creatorName | String | `María Demo` |
| title | String | `Stream de prueba - EroticLiveX` |
| isLive | Boolean | `true` |
| viewers | Number | `42` |
| startedAt | Timestamp | (fecha actual) |

✅ **Resultado esperado:** Se agrega la colección `streams`

---

### COLECCIÓN 3: marketplace

#### Paso 1: Crear colección
1. Haz clic en **"+ Crear colección"**
2. **Nombre de colección:** `marketplace`
3. Haz clic en **"Siguiente"**

#### Paso 2: Agregar documento
1. **ID del documento:** `item_demo_001`
2. Haz clic en **"Guardar"**

#### Paso 3: Agregar campos
| Campo | Tipo | Valor |
|-------|------|-------|
| itemId | String | `item_demo_001` |
| sellerId | String | `user_demo_001` |
| sellerName | String | `María Demo` |
| title | String | `Pack exclusivo - 10 fotos` |
| price | Number | `9.99` |
| inStock | Boolean | `true` |
| rating | Number | `4.9` |
| createdAt | Timestamp | (fecha actual) |

✅ **Resultado esperado:** Se agrega la colección `marketplace`

---

### COLECCIÓN 4: messages

#### Paso 1: Crear colección
1. Haz clic en **"+ Crear colección"**
2. **Nombre de colección:** `messages`
3. Haz clic en **"Siguiente"**

#### Paso 2: Agregar documento
1. **ID del documento:** `conv_user_demo_001_user_demo_002`
2. Haz clic en **"Guardar"**

#### Paso 3: Agregar campos
| Campo | Tipo | Valor |
|-------|------|-------|
| conversationId | String | `conv_user_demo_001_user_demo_002` |
| participants | Array | (tipo map/objeto, agregar user_demo_001, user_demo_002) |
| lastMessage | String | `¡Hola!` |
| lastMessageTime | Timestamp | (fecha actual) |
| isActive | Boolean | `true` |

✅ **Resultado esperado:** Se agrega la colección `messages`

---

### COLECCIÓN 5: transactions

#### Paso 1: Crear colección
1. Haz clic en **"+ Crear colección"**
2. **Nombre de colección:** `transactions`
3. Haz clic en **"Siguiente"**

#### Paso 2: Agregar documento
1. **ID del documento:** `tx_demo_001`
2. Haz clic en **"Guardar"**

#### Paso 3: Agregar campos
| Campo | Tipo | Valor |
|-------|------|-------|
| transactionId | String | `tx_demo_001` |
| buyerId | String | `user_demo_002` |
| sellerId | String | `user_demo_001` |
| amount | Number | `8.49` |
| paymentStatus | String | `completed` |
| createdAt | Timestamp | (fecha actual) |

✅ **Resultado esperado:** Se agrega la colección `transactions`

---

## 🔐 Agregar Reglas de Seguridad

### Paso 1: Ir a tab de Reglas
1. En la sección de Firestore, ve a la pestaña **"Reglas"** (al lado de "Datos")
2. Verás el código actual de reglas

### Paso 2: Reemplazar reglas
Copia y pega este código:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Usuarios: Públicos para leer, solo editar el suyo
    match /users/{uid} {
      allow read: if true;
      allow write: if request.auth.uid == uid;
    }
    // Streams: Público para leer
    match /streams/{streamId} {
      allow read: if true;
      allow create, update, delete: if request.auth.uid == resource.data.creatorId;
    }
    // Marketplace: Público para leer
    match /marketplace/{itemId} {
      allow read: if true;
      allow create, update, delete: if request.auth.uid == resource.data.sellerId;
    }
    // Mensajes: Solo participantes
    match /messages/{conversationId} {
      allow read, write: if request.auth.uid in resource.data.participants;
    }
    // Transacciones: Comprador y vendedor
    match /transactions/{transactionId} {
      allow read: if request.auth.uid in [resource.data.buyerId, resource.data.sellerId];
    }
  }
}
```

### Paso 3: Publicar reglas
1. Haz clic en **"Publicar"** (botón azul abajo a la derecha)
2. Espera a que se actualice (mostrará "Actualizar con éxito")

✅ **Listo!** Las reglas están activas

---

## ✅ Verificación Final

Tu consola de Firestore debería mostrar:

```
Firestore Database

📁 users
   └─ user_demo_001
      ├─ uid
      ├─ email
      ├─ displayName
      ├─ isCreator
      └─ ...

📁 streams
   └─ stream_demo_001
      ├─ streamId
      ├─ creatorId
      ├─ title
      └─ ...

📁 marketplace
   └─ item_demo_001
      ├─ itemId
      ├─ title
      ├─ price
      └─ ...

📁 messages
   └─ conv_...
      ├─ participants
      ├─ lastMessage
      └─ ...

📁 transactions
   └─ tx_demo_001
      ├─ transactionId
      ├─ amount
      └─ ...
```

---

## 🚀 Siguiente Paso

Una vez creada la BD:

### Android
- Abre Android Studio
- Sincroniza Gradle (Click "Sync Now")
- Ejecuta la app y prueba login

### iOS
- Ejecuta `pod install` en terminal
- Abre Xcode
- Ejecuta la app y prueba login

### Spring Boot Backend
- En `src/main/java/.../controller/`, crea endpoints para:
  - GET /api/users/{uid} → Leer de Firestore
  - POST /api/streams → Crear stream
  - GET /api/streams → Listar streams activos
  - etc.

---

## 💡 Tips

✅ **Usar Firestore Emulator** para testing local:
```bash
firebase emulators:start
```

✅ **Monitorar actividad** en Firebase Console:
- Vé a "Firestore Database" → "Monitor" tab
- Verás operaciones en tiempo real

✅ **Hacer Backup**:
- Vé a "Firestore Database" → "Backups"
- Crea un backup manual

---

**¡La BD de Firestore está lista para ser usada por tus apps!** 🎉
