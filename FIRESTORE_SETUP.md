# 🔥 Configuración de Firestore - EroticLiveX

## Colecciones y Estructura de Datos

### 1. COLECCIÓN: users
**Descripción:** Perfiles de usuarios del sistema

**Documento de ejemplo:**
```
Ruta: /users/{uid}

{
  "uid": "user_001",
  "email": "creator@eroticlivex.com",
  "displayName": "María Creator",
  "photoURL": "gs://eroticlivex.appspot.com/users/user_001/profile.jpg",
  "bio": "Creadora de contenido exclusivo",
  "isCreator": true,
  "isVerified": true,
  "rating": 4.8,
  "followers": 1250,
  "following": 89,
  "totalEarnings": 5430.50,
  "createdAt": "2024-01-15T08:30:00Z",
  "updatedAt": "2024-04-09T10:30:00Z",
  "lastLogin": "2024-04-09T10:30:00Z",
  "accountStatus": "active",
  "preferences": {
    "notificationsEnabled": true,
    "privateMessages": true,
    "language": "es"
  }
}
```

**Índices recomendados:**
- isCreator (Ascending)
- rating (Descending)
- createdAt (Descending)

---

### 2. COLECCIÓN: streams
**Descripción:** Transmisiones en vivo y grabadas

**Documento de ejemplo:**
```
Ruta: /streams/{streamId}

{
  "streamId": "stream_20240409_001",
  "creatorId": "user_001",
  "creatorName": "María Creator",
  "creatorPhoto": "gs://eroticlivex.appspot.com/users/user_001/profile.jpg",
  "title": "Sesión exclusiva - 50% descuento",
  "description": "Contenido premium en vivo con interacción directa",
  "category": "premium",
  "thumbnailURL": "gs://eroticlivex.appspot.com/streams/stream_20240409_001/thumb.jpg",
  "isLive": true,
  "isRecorded": false,
  "viewers": 45,
  "maxViewers": 150,
  "startedAt": "2024-04-09T10:30:00Z",
  "scheduledEndAt": "2024-04-09T11:30:00Z",
  "duration": 1800,
  "tipsReceived": 420.75,
  "tags": ["exclusivo", "premium", "en-vivo"],
  "rating": 4.9,
  "comments": 128,
  "streamURL": "rtmps://live-api-s.facebook.com:443/rtmp/",
  "accessLevel": "premium",
  "pricePerMinute": 0.10,
  "status": "active"
}
```

**Índices recomendados:**
- creatorId, isLive (Ascending)
- startedAt (Descending)
- isLive, viewers (Descending)

---

### 3. COLECCIÓN: marketplace
**Descripción:** Productos y servicios en venta

**Documento de ejemplo:**
```
Ruta: /marketplace/{itemId}

{
  "itemId": "item_20240409_001",
  "sellerId": "user_001",
  "sellerName": "María Creator",
  "sellerRating": 4.8,
  "title": "Pack exclusivo - 30 fotos + 5 videos HD",
  "description": "Contenido exclusivo descargable\n- 30 fotos de alta resolución\n- 5 videos en 1080p\n- Acceso temporal: 30 días\n- Permitido descargar",
  "category": "digital-content",
  "subcategory": "photos-videos",
  "price": 24.99,
  "currency": "USD",
  "images": [
    "gs://eroticlivex.appspot.com/marketplace/item_001/image_1.jpg",
    "gs://eroticlivex.appspot.com/marketplace/item_001/image_2.jpg",
    "gs://eroticlivex.appspot.com/marketplace/item_001/image_3.jpg"
  ],
  "inStock": true,
  "inventory": 999,
  "sales": 342,
  "rating": 4.9,
  "reviews": 87,
  "deliveryType": "instant-download",
  "fileURL": "gs://eroticlivex.appspot.com/marketplace/item_001/pack.zip",
  "fileSize": "845 MB",
  "tags": ["exclusivo", "contenido-premium", "fotos", "videos"],
  "createdAt": "2024-02-15T08:30:00Z",
  "updatedAt": "2024-04-09T10:30:00Z",
  "discountActive": true,
  "discountPercent": 15,
  "originalPrice": 29.99
}
```

**Índices recomendados:**
- sellerId (Ascending)
- category, price (Ascending)
- rating (Descending)
- inStock, createdAt (Descending)

---

### 4. COLECCIÓN: messages
**Descripción:** Mensajería privada entre usuarios

**Documento de ejemplo:**
```
Ruta: /messages/{conversationId}

{
  "conversationId": "conv_user001_user002",
  "participants": ["user_001", "user_002"],
  "participantNames": ["María Creator", "Juan Usuario"],
  "participantPhotos": {
    "user_001": "gs://eroticlivex.appspot.com/users/user_001/profile.jpg",
    "user_002": "gs://eroticlivex.appspot.com/users/user_002/profile.jpg"
  },
  "lastMessage": "¿A qué hora es la próxima transmisión?",
  "lastMessageSenderId": "user_002",
  "lastMessageTime": "2024-04-09T10:25:00Z",
  "messageCount": 45,
  "unreadCount": {
    "user_001": 0,
    "user_002": 2
  },
  "createdAt": "2024-04-01T14:20:00Z",
  "updatedAt": "2024-04-09T10:25:00Z",
  "isActive": true,
  "messages": [
    {
      "messageId": "msg_001",
      "senderId": "user_001",
      "senderName": "María Creator",
      "text": "¡Hola! ¿Cómo estás?",
      "type": "text",
      "timestamp": "2024-04-09T09:00:00Z",
      "read": true,
      "readAt": "2024-04-09T09:05:00Z",
      "attachments": []
    },
    {
      "messageId": "msg_002",
      "senderId": "user_002",
      "senderName": "Juan Usuario",
      "text": "¡Muy bien! ¿Cuándo es el próximo stream?",
      "type": "text",
      "timestamp": "2024-04-09T09:10:00Z",
      "read": true,
      "readAt": "2024-04-09T09:15:00Z",
      "attachments": []
    },
    {
      "messageId": "msg_003",
      "senderId": "user_002",
      "senderName": "Juan Usuario",
      "text": "¿A qué hora es la próxima transmisión?",
      "type": "text",
      "timestamp": "2024-04-09T10:25:00Z",
      "read": false,
      "readAt": null,
      "attachments": []
    }
  ]
}
```

**Índices recomendados:**
- participants (Array)
- lastMessageTime (Descending)

---

### 5. COLECCIÓN ADICIONAL: transactions (Transacciones)
**Descripción:** Registro de compras y pagos

**Documento de ejemplo:**
```
Ruta: /transactions/{transactionId}

{
  "transactionId": "tx_20240409_001",
  "buyerId": "user_002",
  "buyerName": "Juan Usuario",
  "sellerId": "user_001",
  "sellerName": "María Creator",
  "itemId": "item_20240409_001",
  "itemName": "Pack exclusivo - 30 fotos + 5 videos HD",
  "amount": 21.24,
  "originalAmount": 24.99,
  "discount": 3.75,
  "discountPercent": 15,
  "currency": "USD",
  "paymentMethod": "credit_card",
  "paymentStatus": "completed",
  "transactionStatus": "delivered",
  "createdAt": "2024-04-09T10:00:00Z",
  "completedAt": "2024-04-09T10:05:00Z",
  "rating": 5,
  "review": "Excelente contenido, muy satisfecho",
  "commission": 0.53,
  "platformFee": 2.12,
  "sellerEarnings": 18.59
}
```

---

## 🔐 Reglas de Seguridad de Firestore

Copia estas reglas en tu consola de Firebase:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Usuarios: Cada usuario puede leer todos los perfiles, pero solo editar el suyo
    match /users/{uid} {
      allow read: if true; // Públicos para búsqueda de creators
      allow write: if request.auth.uid == uid;
      allow delete: if request.auth.uid == uid;
    }
    
    // Streams: Públicos para leer, solo el creator puede crear/editar
    match /streams/{streamId} {
      allow read: if true; // Públicos
      allow create: if request.auth.uid != null;
      allow update: if request.auth.uid == resource.data.creatorId;
      allow delete: if request.auth.uid == resource.data.creatorId;
    }
    
    // Marketplace: Públicos para leer, solo el seller puede crear/editar
    match /marketplace/{itemId} {
      allow read: if true; // Públicos
      allow create: if request.auth.uid != null;
      allow update: if request.auth.uid == resource.data.sellerId;
      allow delete: if request.auth.uid == resource.data.sellerId;
    }
    
    // Mensajes: Solo entre los participantes
    match /messages/{conversationId} {
      allow read: if request.auth.uid in resource.data.participants;
      allow create: if request.auth.uid in request.resource.data.participants;
      allow update: if request.auth.uid in resource.data.participants;
      allow delete: if request.auth.uid in resource.data.participants;
    }
    
    // Transacciones: Público para lectura del comprador/vendedor
    match /transactions/{transactionId} {
      allow read: if request.auth.uid in [resource.data.buyerId, resource.data.sellerId];
      allow create: if request.auth.uid == request.resource.data.buyerId;
      allow update: if request.auth.uid in [resource.data.buyerId, resource.data.sellerId];
    }
  }
}
```

---

## 📋 Checklist para crear la BD

- [ ] Abre Firebase Console → Firestore Database
- [ ] Crea colección **users** con documento de ejemplo
- [ ] Crea colección **streams** con documento de ejemplo
- [ ] Crea colección **marketplace** con documento de ejemplo
- [ ] Crea colección **messages** con documento de ejemplo
- [ ] Crea colección **transactions** con documento de ejemplo
- [ ] Configura las reglas de seguridad (copy-paste del código arriba)
- [ ] Publica las reglas
- [ ] Verifica que aparezcan todas las colecciones en Firestore Console

---

## ✅ Verificación

Una vez creada la BD, deberías ver en Firebase Console:

```
Firestore Database
├── users (con 1+ documento)
├── streams (con 1+ documento)
├── marketplace (con 1+ documento)
├── messages (con 1+ documento)
└── transactions (con 1+ documento)
```

¡Y listo! La BD estará lista para que la usen Android, iOS y tu API de Spring Boot. 🚀
