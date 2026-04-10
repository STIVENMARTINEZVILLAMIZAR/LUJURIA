# 🌐 Multi-Platform Architecture - EroticLiveX

## Project Overview

EroticLiveX is a full-stack, multi-platform application consisting of:

1. **Backend (Java/Spring Boot)** - REST API and business logic
2. **Android (Kotlin)** - Native Android app with Jetpack Compose
3. **iOS (Swift)** - Native iOS app with SwiftUI
4. **Frontend (Vue/React)** - Web application (existing)

All platforms share the same Firebase backend for authentication, database, and messaging.

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Firebase Backend                          │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Auth  │  Firestore  │  Storage  │  Messaging       │   │
│  │ (Sign-up, Login, Verification) → Database Operations │   │
│  │ (User profiles, Streams, Messages, Marketplace)     │   │
│  │ (Media uploads, Thumbnails, Profile pics)           │   │
│  │ (Push notifications, In-app messaging)              │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
       ▲                   ▲                   ▲
       │                   │                   │
       │                   │                   │
 ┌─────▼─────┐    ┌────────▼────────┐  ┌─────▼─────────┐
 │   Spring   │    │   Android App   │  │   iOS App     │
 │  Boot API  │    │  (Kotlin/Compose) │  (Swift/SwiftUI)
 │            │    │                 │  │               │
 │ - REST     │    │ - Firebase SDK  │  │ Firebase SDK  │
 │ - Auth     │    │ - Jetpack       │  │ - Combine     │
 │ - Services │    │ - Coroutines    │  │ - async/await │
 │ - Database │    │ - MVVM Pattern  │  │ - MVVM Pattern│
 └────────────┘    └─────────────────┘  └───────────────┘
       ▲                                         ▲
       │                                         │
    http://localhost:8080                   Firebase REST API
```

## 📊 Data Flow

### Authentication Flow
```
User (Client)
  ↓
[Android/iOS/Web]
  ↓
Firebase Auth
  ↓
Token issued
  ↓
Signed in state (local cache)
  ↓
[App shows authenticated UI]
```

### Data Synchronization
```
[Android/iOS Client]
  ↓
Reads/Writes data
  ↓
Firebase Firestore
  ↓
Real-time listeners activated
  ↓
[All clients see updates in real-time]
```

### Push Notifications
```
Server (can be any platform)
  ↓
Firebase Cloud Messaging
  ↓
User token lookup
  ↓
[Android/iOS device receives notification]
  ↓
Notification displayed or handled in-app
```

## 🗂️ Repository Structure

```
EroticLiveX/
├── backend/                              # Java/Spring Boot
│   ├── src/main/java/...                # Business logic
│   ├── src/test/java/...                # Unit tests
│   ├── pom.xml                          # Maven (Java 21)
│   └── mvnw/mvnw.cmd                    # Maven wrapper
│
├── frontend/                             # Vue/React (existing)
│   ├── src/
│   ├── package.json
│   └── vite.config.js
│
├── android/                              # Kotlin/Android
│   ├── app/
│   │   ├── build.gradle.kts             # Firebase BOM 34.11.0
│   │   ├── src/main/kotlin/...          # Kotlin source
│   │   ├── google-services.json         # Firebase config
│   │   └── AndroidManifest.xml
│   ├── build.gradle.kts                 # Google Services plugin 4.4.4
│   ├── Gradle wrapper                   # (Android built-in)
│   ├── ANDROID_SETUP.md
│   ├── QUICK_START.md
│   └── README.md
│
├── ios/                                  # Swift/iOS
│   ├── EroticLiveX/
│   │   ├── EroticLiveXApp.swift         # SwiftUI App + AppDelegate
│   │   ├── Views/                       # SwiftUI views
│   │   ├── Services/                    # Firebase managers
│   │   ├── Models/                      # Data models
│   │   ├── GoogleService-Info.plist     # Firebase config
│   │   └── Info.plist
│   ├── Podfile                          # CocoaPods
│   ├── IOS_SETUP.md
│   ├── IOS_QUICK_START.md
│   ├── IOS_FIREBASE_CONFIG.md
│   └── README.md
│
├── docker-compose.yml                   # Optional: Local Firebase emulator
└── README.md                             # Main project documentation
```

## 🔐 Firebase Configuration

### Firebase Project Settings
- **Project Name:** eroticlivex
- **Bundle ID (iOS):** com.company.EroticLiveX
- **Package Name (Android):** com.company.eroticlivex
- **Web URL:** (optional)

### Shared Configuration Files
| Platform | File | Location |
|----------|------|----------|
| Android | `google-services.json` | `android/app/` |
| iOS | `GoogleService-Info.plist` | `ios/EroticLiveX/` |
| Web | `firebaseConfig.json` | `frontend/src/` (or embed) |

## 🚀 Development Workflow

### Backend (Spring Boot)
```bash
cd .
mvn clean compile
mvn test
mvn spring-boot:run
# Server runs on http://localhost:8080
```

### Android
```bash
cd android
./gradlew build
./gradlew installDebug
# Or open in Android Studio and click Run
```

### iOS
```bash
cd ios
pod install
open EroticLiveX.xcworkspace
# Build with Cmd + B, Run with Cmd + R
```

### Frontend (Vue/React)
```bash
cd frontend
npm install
npm run dev
# Server runs on http://localhost:5173
```

## 🔄 Common Development Tasks

### Add New User Field
1. **Backend (Spring):**
   - Add field to User entity
   - Create migration
   - Expose via REST API

2. **Android:**
   - Update UserModel data class
   - Update UI to display/input field
   - Update FirebaseFirestoreUtils

3. **iOS:**
   - Update UserModel struct
   - Update AuthView or ProfileView
   - Update FirebaseFirestoreManager

4. **Frontend:**
   - Update user state
   - Update UI component
   - Test with API

### Add New Firebase Collection
1. **Backend:**
   - Document corresponding entity/service if needed
   - Provide API endpoint

2. **Android/iOS:**
   - Create data model
   - Create Firebase service methods
   - Create UI screens
   - Add listener for real-time updates

## 🔗 API Contracts

### Authentication Flow
**Both mobile apps use Firebase Auth directly** (no backend required initially):

```
POST /api/auth/signup → Firebase handles
POST /api/auth/login → Firebase handles
POST /api/auth/logout → Firebase handles
POST /api/auth/refresh → Firebase handles
```

### User Data Flow
**Via Firestore (all clients access same data)**:

```
Collection: /users/{uid}
├── Fields:
│   ├── email: string
│   ├── displayName: string
│   ├── photoURL: URL
│   ├── createdAt: timestamp
│   └── updatedAt: timestamp
```

### Firestore Collections (Shared)
```
/users
  /{uid}
    ├── email, displayName, photoURL, ...
    
/streams
  /{streamId}
    ├── creatorId, title, description, isLive, viewers, ...
    
/marketplace
  /{itemId}
    ├── sellerId, title, price, description, media, ...
    
/messages
  /{conversationId}
    ├── participants, messages[], lastMessage, ...
```

## 📊 Deployment Checklist

### Backend (Spring Boot)
- [ ] Java 21 LTS installed
- [ ] All dependencies updated (`mvn clean test`)
- [ ] No CVEs in dependencies (scan completed ✅)
- [ ] API endpoints tested
- [ ] Docker image built (optional)
- [ ] Deployed to production server

### Android
- [ ] `google-services.json` included
- [ ] Firebase BOM v34.11.0 configured
- [ ] Google Services plugin v4.4.4 configured
- [ ] All permissions in AndroidManifest.xml
- [ ] Signed APK built
- [ ] App tested on multiple devices/API levels
- [ ] Uploaded to Google Play Store

### iOS
- [ ] `GoogleService-Info.plist` included
- [ ] CocoaPods dependencies installed
- [ ] All permissions in Info.plist
- [ ] APNs certificate configured
- [ ] App code signed
- [ ] Tested on simulator and physical device
- [ ] Submitted to App Store

### Frontend
- [ ] Environment variables configured
- [ ] Firebase config included
- [ ] Built for production (`npm run build`)
- [ ] Deployed to hosting (Vercel, Netlify, etc.)

## 🛠️ Troubleshooting Multi-Platform

### Firebase Not Working on Mobile
- **Check:** Firebase project enables required services
- **Check:** `google-services.json` or `GoogleService-Info.plist` present
- **Check:** Bundle IDs match Firebase configuration
- **Test:** Create test user in Firebase Console → Authentication

### Real-time Sync Not Working
- **Check:** Firestore rules allow read/write (see IOS_FIREBASE_CONFIG.md)
- **Check:** User is authenticated
- **Check:** Listeners are attached (not garbage collected)
- **Monitor:** Firebase Console → Firestore → Monitor tab

### Push Notifications Failing
- **Android:** Check FCM setup and device token registration
- **iOS:** Verify APNs certificate in Firebase Console
- **Both:** Test sending from Firebase Console → Cloud Messaging

### Authentication Token Issues
- **Android:** Firebase SDK handles tokens automatically
- **iOS:** Firebase SDK handles tokens automatically
- **Problem:** Clear app data and re-login if stuck

## 📚 Documentation Links

### Backend
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Spring Security](https://spring.io/projects/spring-security)
- [Project README](./README.md)

### Android
- [Android Developer Guide](https://developer.android.com/)
- [Jetpack Compose](https://developer.android.com/jetpack/compose)
- [Kotlin Coroutines](https://kotlinlang.org/docs/coroutines-overview.html)
- [android/README.md](android/README.md)
- [android/ANDROID_SETUP.md](android/ANDROID_SETUP.md)

### iOS
- [Apple Developer](https://developer.apple.com/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Combine Framework](https://developer.apple.com/documentation/combine)
- [ios/README.md](ios/README.md)
- [ios/IOS_SETUP.md](ios/IOS_SETUP.md)

### Firebase
- [Firebase Documentation](https://firebase.google.com/docs)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [Cloud Firestore](https://firebase.google.com/docs/firestore)
- [Firebase Messaging](https://firebase.google.com/docs/cloud-messaging)

## 🎯 Next Steps

1. **Backend Testing**
   - Run: `mvn clean test`
   - Start: `mvn spring-boot:run`

2. **Android Development**
   - Run: `cd android && ./gradlew installDebug`
   - Test authentication flows

3. **iOS Development**
   - Run: `cd ios && pod install && open EroticLiveX.xcworkspace`
   - Test authentication flows

4. **Integration Testing**
   - Login on Android
   - Login on iOS
   - Create data on Android
   - Verify it appears on iOS (real-time sync)

5. **Production**
   - Build release binaries
   - Upload to app stores
   - Monitor Firebase Console

---

**All Code:** Version 1.0 | **Last Updated:** 2024 | **Platform:** Multi-platform (Java Backend + Android + iOS + Web)
