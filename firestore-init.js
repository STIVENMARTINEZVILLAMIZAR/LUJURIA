// Script para inicializar datos de prueba en Firestore
// Puedes ejecutar esto desde Firebase Console → Functions o desde tu app

const admin = require('firebase-admin');

// Este script crea datos de ejemplo en Firestore
async function initializeFirestoreData() {
  const db = admin.firestore();
  
  try {
    console.log('? Iniciando creación de datos en Firestore...');
    
    // 1. CREAR USUARIO DE PRUEBA
    const userId = 'user_demo_001';
    await db.collection('users').doc(userId).set({
      uid: userId,
      email: 'demo@eroticlivex.com',
      displayName: 'María Demo',
      photoURL: 'https://via.placeholder.com/150',
      bio: 'Creadora de contenido demo',
      isCreator: true,
      isVerified: true,
      rating: 4.8,
      followers: 1250,
      following: 89,
      totalEarnings: 5430.50,
      createdAt: admin.firestore.Timestamp.now(),
      updatedAt: admin.firestore.Timestamp.now(),
      lastLogin: admin.firestore.Timestamp.now(),
      accountStatus: 'active',
      preferences: {
        notificationsEnabled: true,
        privateMessages: true,
        language: 'es'
      }
    });
    console.log('✅ Usuario creado: ' + userId);
    
    // 2. CREAR STREAM DE PRUEBA
    const streamId = 'stream_demo_001';
    await db.collection('streams').doc(streamId).set({
      streamId: streamId,
      creatorId: userId,
      creatorName: 'María Demo',
      creatorPhoto: 'https://via.placeholder.com/150',
      title: 'Stream de prueba - EroticLiveX Demo',
      description: 'Este es un stream de ejemplo para testing',
      category: 'premium',
      thumbnailURL: 'https://via.placeholder.com/400x300',
      isLive: true,
      isRecorded: false,
      viewers: 42,
      maxViewers: 150,
      startedAt: admin.firestore.Timestamp.now(),
      scheduledEndAt: new Date(Date.now() + 3600000), // +1 hora
      duration: 1800,
      tipsReceived: 420.75,
      tags: ['demo', 'testing', 'prueba'],
      rating: 4.9,
      comments: 128,
      accessLevel: 'premium',
      pricePerMinute: 0.10,
      status: 'active'
    });
    console.log('✅ Stream creado: ' + streamId);
    
    // 3. CREAR PRODUCTO MARKETPLACE
    const itemId = 'item_demo_001';
    await db.collection('marketplace').doc(itemId).set({
      itemId: itemId,
      sellerId: userId,
      sellerName: 'María Demo',
      sellerRating: 4.8,
      title: 'Pack exclusivo demo - 10 fotos + 3 videos',
      description: 'Contenido exclusivo de prueba\n- 10 fotos de alta resolución\n- 3 videos en 1080p\n- Acceso temporal: 30 días',
      category: 'digital-content',
      subcategory: 'photos-videos',
      price: 9.99,
      currency: 'USD',
      images: [
        'https://via.placeholder.com/300x300?text=Foto+1',
        'https://via.placeholder.com/300x300?text=Foto+2',
        'https://via.placeholder.com/300x300?text=Foto+3'
      ],
      inStock: true,
      inventory: 999,
      sales: 342,
      rating: 4.9,
      reviews: 87,
      deliveryType: 'instant-download',
      tags: ['demo', 'contenido', 'fotos'],
      createdAt: admin.firestore.Timestamp.now(),
      updatedAt: admin.firestore.Timestamp.now(),
      discountActive: true,
      discountPercent: 15,
      originalPrice: 11.99
    });
    console.log('✅ Producto marketplace creado: ' + itemId);
    
    // 4. CREAR SEGUNDO USUARIO PARA MENSAJES
    const userId2 = 'user_demo_002';
    await db.collection('users').doc(userId2).set({
      uid: userId2,
      email: 'juan@eroticlivex.com',
      displayName: 'Juan Usuario Demo',
      photoURL: 'https://via.placeholder.com/150',
      bio: 'Usuario de prueba',
      isCreator: false,
      isVerified: false,
      rating: 4.5,
      followers: 150,
      following: 45,
      totalEarnings: 0,
      createdAt: admin.firestore.Timestamp.now(),
      updatedAt: admin.firestore.Timestamp.now(),
      lastLogin: admin.firestore.Timestamp.now(),
      accountStatus: 'active',
      preferences: {
        notificationsEnabled: true,
        privateMessages: true,
        language: 'es'
      }
    });
    console.log('✅ Usuario 2 creado: ' + userId2);
    
    // 5. CREAR CONVERSACIÓN DE MENSAJES
    const conversationId = `conv_${userId}_${userId2}`;
    await db.collection('messages').doc(conversationId).set({
      conversationId: conversationId,
      participants: [userId, userId2],
      participantNames: ['María Demo', 'Juan Usuario Demo'],
      participantPhotos: {
        [userId]: 'https://via.placeholder.com/150',
        [userId2]: 'https://via.placeholder.com/150'
      },
      lastMessage: '¡Hola!',
      lastMessageSenderId: userId,
      lastMessageTime: admin.firestore.Timestamp.now(),
      messageCount: 1,
      unreadCount: {
        [userId]: 0,
        [userId2]: 1
      },
      createdAt: admin.firestore.Timestamp.now(),
      updatedAt: admin.firestore.Timestamp.now(),
      isActive: true,
      messages: [
        {
          messageId: 'msg_demo_001',
          senderId: userId,
          senderName: 'María Demo',
          text: '¡Hola! Bienvenido a EroticLiveX',
          type: 'text',
          timestamp: admin.firestore.Timestamp.now(),
          read: false,
          attachments: []
        }
      ]
    });
    console.log('✅ Conversación de mensajes creada: ' + conversationId);
    
    // 6. CREAR TRANSACCIÓN DE EJEMPLO
    const transactionId = 'tx_demo_001';
    await db.collection('transactions').doc(transactionId).set({
      transactionId: transactionId,
      buyerId: userId2,
      buyerName: 'Juan Usuario Demo',
      sellerId: userId,
      sellerName: 'María Demo',
      itemId: itemId,
      itemName: 'Pack exclusivo demo',
      amount: 8.49,
      originalAmount: 9.99,
      discount: 1.50,
      discountPercent: 15,
      currency: 'USD',
      paymentMethod: 'credit_card',
      paymentStatus: 'completed',
      transactionStatus: 'delivered',
      createdAt: admin.firestore.Timestamp.now(),
      completedAt: admin.firestore.Timestamp.now(),
      rating: 5,
      review: 'Excelente contenido, muy satisfecho con la compra',
      commission: 0.21,
      platformFee: 0.85,
      sellerEarnings: 7.43
    });
    console.log('✅ Transacción creada: ' + transactionId);
    
    console.log('\n✨ ¡Base de datos inicializada exitosamente!\n');
    console.log('📊 Datos creados:');
    console.log('  • 2 usuarios');
    console.log('  • 1 stream en vivo');
    console.log('  • 1 producto en marketplace');
    console.log('  • 1 conversación de mensajes');
    console.log('  • 1 transacción de ejemplo\n');
    
  } catch (error) {
    console.error('❌ Error creando datos:', error);
    throw error;
  }
}

// Ejecutar
initializeFirestoreData()
  .then(() => {
    console.log('? Proceso completado');
    process.exit(0);
  })
  .catch(error => {
    console.error('? Error:', error);
    process.exit(1);
  });
