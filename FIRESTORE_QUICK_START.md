# ⚡ Guía Rápida - Crear Firestore en 5 minutos

## 🚀 TL;DR (Resumen ejecutivo)

### Necesitas 5 Colecciones:
1. **users** - Perfiles de usuarios
2. **streams** - Transmisiones en vivo
3. **marketplace** - Productos/servicios
4. **messages** - Mensajería privada
5. **transactions** - Historial de compras

---

## ⚡ Quick Start

### 1️⃣ Ir a Firestore
```
Firebase Console (https://console.firebase.google.com/)
→ Proyecto: eroticlivex
→ Firestore Database (en el menú izquierdo)
```

### 2️⃣ Crear 5 Colecciones
Repite este proceso 5 veces:

**CLICK:** "+ Crear colección"
**ESCRIBIR:** (nombre de la colección)
**CLICK:** Siguiente → Guardar

| # | Colección | ID del documento |
|---|-----------|------------------|
| 1 | `users` | `user_demo_001` |
| 2 | `streams` | `stream_demo_001` |
| 3 | `marketplace` | `item_demo_001` |
| 4 | `messages` | `conv_demo_001` |
| 5 | `transactions` | `tx_demo_001` |

### 3️⃣ Agregar algunos campos básicos

**Dentro de cada documento, click "+ Agregar campo":**

#### users
```
uid = "user_demo_001" (string)
email = "demo@eroticlivex.com" (string)
displayName = "María Demo" (string)
createdAt = (fecha actual) (timestamp)
```

#### streams
```
streamId = "stream_demo_001" (string)
creatorId = "user_demo_001" (string)
title = "Stream Demo" (string)
isLive = true (boolean)
```

#### marketplace
```
itemId = "item_demo_001" (string)
sellerId = "user_demo_001" (string)
title = "Producto Demo" (string)
price = 9.99 (number)
```

#### messages
```
conversationId = "conv_demo_001" (string)
participants = ["user_demo_001", "user_demo_002"] (array)
lastMessage = "¡Hola!" (string)
```

#### transactions
```
transactionId = "tx_demo_001" (string)
buyerId = "user_demo_002" (string)
sellerId = "user_demo_001" (string)
amount = 8.49 (number)
```

### 4️⃣ Configurar Reglas (IMPORTANTE)

**Vé a la pestaña "Reglas" y copia esto:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read: if true;
      allow write: if request.auth.uid == uid;
    }
    match /streams/{streamId} {
      allow read: if true;
      allow create, update, delete: if request.auth.uid == resource.data.creatorId;
    }
    match /marketplace/{itemId} {
      allow read: if true;
      allow create, update, delete: if request.auth.uid == resource.data.sellerId;
    }
    match /messages/{conversationId} {
      allow read, write: if request.auth.uid in resource.data.participants;
    }
    match /transactions/{transactionId} {
      allow read: if request.auth.uid in [resource.data.buyerId, resource.data.sellerId];
    }
  }
}
```

**CLICK:** "Publicar" (botón azul)

### 5️⃣ ¡LISTO! 🎉

Ahora tu Firestore tiene la estructura completa.

---

## 📊 Estructura Visual

```
Firestore (eroticlivex)
│
├── 📁 users
│   └─ user_demo_001 {uid, email, displayName, ...}
│
├── 📁 streams
│   └─ stream_demo_001 {streamId, creatorId, title, isLive, ...}
│
├── 📁 marketplace
│   └─ item_demo_001 {itemId, sellerId, title, price, ...}
│
├── 📁 messages
│   └─ conv_demo_001 {conversationId, participants, lastMessage, ...}
│
└── 📁 transactions
    └─ tx_demo_001 {transactionId, buyerId, sellerId, amount, ...}
```

---

## ✅ Checklist

- [ ] Abierto Firebase Console
- [ ] Seleccionado proyecto "eroticlivex"
- [ ] En Firestore Database
- [ ] Creada colección "users"
- [ ] Creada colección "streams"
- [ ] Creada colección "marketplace"
- [ ] Creada colección "messages"
- [ ] Creada colección "transactions"
- [ ] Configuradas reglas de seguridad
- [ ] Publicadas las reglas
- [ ] Veo las 5 colecciones en Firestore

---

## 🔗 Referencias

- **Documentación completa:** Ver `FIRESTORE_SETUP.md`
- **Paso a paso visual:** Ver `FIRESTORE_MANUAL_SETUP.md`
- **Script inicialización:** Ver `firestore-init.js`

---

**Ahora puedes:**
- ✅ Probar login en Android/iOS
- ✅ Crear usuarios desde las apps
- ✅ Guardar streams en tiempo real
- ✅ Comprar productos en marketplace
- ✅ Enviar mensajes privados
- ✅ Registrar transacciones

¡Listo para el desarrollo! 🚀
