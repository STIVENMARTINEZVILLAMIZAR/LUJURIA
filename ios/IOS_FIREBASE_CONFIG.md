# 🔥 Firebase iOS Configuration - EroticLiveX

## Configuration Summary

| Setting | Value |
|---------|-------|
| **Bundle ID** | `com.company.EroticLiveX` |
| **Project ID** | `eroticlivex` |
| **Google App ID** | `1:272346825762:ios:63a075efedd8acfd78367b` |
| **GCM Sender ID** | `272346825762` |
| **API Key** | `AIzaSyDKyAnw8x-zX-fcmuBQUPD1ZU8IeN27GgA` |
| **Storage Bucket** | `eroticlivex.firebasestorage.app` |

## Enabled Services

| Service | Status |
|---------|--------|
| Authentication | ✅ Enabled |
| Cloud Firestore | ✅ Enabled |
| Cloud Storage | ✅ Enabled |
| Cloud Messaging | ✅ Enabled |
| Real-time Database | ✅ Enabled |
| Performance Monitoring | ✅ Enabled |
| Google Analytics | ⚠️ Disabled (can be enabled) |
| App Invites | ✅ Enabled |

## Firebase Integration Files

### GoogleService-Info.plist
- **Location:** `ios/EroticLiveX/GoogleService-Info.plist`
- **Role:** Automatic Firebase configuration
- **Status:** ✅ Included in Xcode project
- **Manual Action:** Add to "Copy Bundle Resources" in Build Phases if missing

### Info.plist
- **Location:** `ios/EroticLiveX/Info.plist`
- **Configuration:**
  - `FirebaseAppDelegateProxyEnabled: true` (Automatic FCM setup)
  - Push notification background mode enabled
  - Camera, microphone, photo library, location permissions

### Podfile
- **Location:** `ios/Podfile`
- **Version:** Firebase latest stable
- **Pods:**
  - `Firebase/Analytics`
  - `Firebase/Auth`
  - `Firebase/Firestore`
  - `Firebase/Database`
  - `Firebase/Storage`
  - `Firebase/Messaging`
  - `Firebase/Performance`

## AppDelegate Configuration

**File:** `EroticLiveXApp.swift`

### Initialization:
```swift
FirebaseApp.configure()
```

### Push Notifications:
- Requests user permission for notifications
- Registers APNs device token
- Handles remote notifications
- Manages FCM token registration

### Listeners:
- `UNUserNotificationCenterDelegate` - Notification handling
- `MessagingDelegate` - FCM token updates

## Authentication Workflow

**Manager Class:** `FirebaseAuthManager.swift`

### Sign Up:
```swift
authManager.signUp(email: String, password: String) { result in
    // Handle result
}
```

### Sign In:
```swift
authManager.signIn(email: String, password: String) { result in
    // Handle result
}
```

### Real-time Auth Listener:
- Automatically detects login/logout
- Updates `@Published` properties for SwiftUI binding
- Switches between AuthView and MainTabView

## Database Operations

**Manager Class:** `FirebaseFirestoreManager.swift`

### CRUD Operations:
```swift
// Create
firestoreManager.createUserDocument(uid: String, userData: [String: Any]) { result in }

// Read
firestoreManager.getUserData(uid: String) { result in }

// Update
firestoreManager.updateUserData(uid: String, updates: [String: Any]) { result in }

// Delete
firestoreManager.deleteUserData(uid: String) { result in }

// Listen
firestoreManager.listenToUserData(uid: String) { result in }
```

## Data Models

**File:** `Models.swift`

```swift
struct UserModel {
    let uid: String
    let email: String
    let displayName: String?
    let photoURL: String?
    let createdAt: Date?
    let updatedAt: Date?
    let isVerified: Bool
}

struct StreamModel {
    let id: String
    let creatorId: String
    let title: String
    let description: String?
    let thumbnailURL: String?
    let isLive: Bool
    let viewers: Int
    let createdAt: Date
}

struct MessageModel {
    let id: String
    let senderId: String
    let receiverId: String
    let content: String
    let timestamp: Date
    let isRead: Bool
}
```

## Firestore Security Rules (Recommended)

Add these rules to your Firestore Console:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
    }
    match /streams/{streamId} {
      allow read: if true;
      allow write: if request.auth.uid == resource.data.creatorId;
    }
    match /messages/{messageId} {
      allow read, write: if request.auth.uid in [resource.data.senderId, resource.data.receiverId];
    }
  }
}
```

## Push Notifications Setup

### Prerequisites:
1. Apple Developer Account
2. APNs certificate created in Apple Developer Console
3. Certificate uploaded to Firebase Console

### In Your App:
```swift
// Automatic handling in AppDelegate
UNUserNotificationCenter.current().requestAuthorizationWithOptions([.alert, .sound, .badge])
UIApplication.shared.registerForRemoteNotifications()
```

### Handle Incoming Messages:
```swift
func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
) {
    // Process notification
    completionHandler([[.banner, .sound, .badge]])
}
```

## Testing Firebase Integration

### 1. Test Authentication
```bash
# Monitor auth state in console
xcodebuild -workspace ios/EroticLiveX.xcworkspace -scheme EroticLiveX -configuration Debug
```

### 2. Test Firestore Connection
- Sign up with test email
- Check Firebase Console → Firestore → Collections → `users`
- Verify user document created

### 3. Test Push Notifications
- Send test notification from Firebase Console
- Verify message appears on device/simulator

### 4. Monitor Analytics
- Use app normally
- Check Firebase Console → Analytics → Real-time

## Troubleshooting

### Firebase not initializing:
- Check `GoogleService-Info.plist` exists
- Verify it's in "Copy Bundle Resources" build phase
- Clean build: **Cmd + Shift + K**

### Auth not persisting after app restart:
- Firebase Auth automatically persists tokens
- Check `FirebaseAuthManager` is using @StateObject
- Verify listener is attached in init()

### Notifications not received:
- Check `Info.plist` has `FirebaseAppDelegateProxyEnabled: true`
- Verify "Push Notifications" capability enabled in Xcode
- Check APNs certificate in Firebase Console

### Firestore permission errors:
- Verify security rules allow the operation
- Check user is authenticated
- Look at Firestore Console error logs

## Deployment Checklist

- [ ] GoogleService-Info.plist added to Xcode project
- [ ] Info.plist configured with correct permissions
- [ ] Podfile pods installed successfully
- [ ] FirebaseApp.configure() called in AppDelegate
- [ ] Push Notifications capability enabled
- [ ] APNs certificate uploaded to Firebase Console
- [ ] Firestore security rules configured
- [ ] All services tested on simulator/device

---

**Documentation:** See [IOS_SETUP.md](IOS_SETUP.md) for detailed setup instructions.
