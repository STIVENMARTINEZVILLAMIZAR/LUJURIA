# 🚀 iOS Quick Start Guide - EroticLiveX

## Get Started in 5 Minutes

### Step 1: Install Dependencies

```bash
cd ios
pod install
```

### Step 2: Open in Xcode

```bash
open EroticLiveX.xcworkspace
```

### Step 3: Build & Run

- Select a simulator or device from the dropdown
- Press **Cmd + R** to build and run
- Or click the **Play** button

### Step 4: Test Authentication

1. **Sign Up:** Enter email and password, tap "Registrarse"
2. **Sign In:** Use the credentials you just created
3. **Main App:** See the TabView with Home, Streams, Marketplace, Messages, Profile

## 📂 File Quick Reference

| File | Purpose |
|------|---------|
| `EroticLiveXApp.swift` | App entry point, Firebase initialization, push notifications setup |
| `ContentView.swift` | Main UI with TabView navigation (5 tabs) |
| `AuthView.swift` | Login/Registration form |
| `FirebaseAuthManager.swift` | Authentication service (Observable) |
| `FirebaseFirestoreManager.swift` | Database operations service |
| `Models.swift` | Data models (UserModel, StreamModel, etc.) |
| `GoogleService-Info.plist` | Firebase configuration |
| `Info.plist` | App permissions and settings |
| `Podfile` | CocoaPods dependencies |

## 🔐 Available Services

✅ **Firebase Auth** - Email/password signup and login
✅ **Cloud Firestore** - User data storage
✅ **Cloud Storage** - Media uploads
✅ **Cloud Messaging** - Push notifications
✅ **Real-time Database** - Live data sync
✅ **Analytics** - User behavior tracking

## 🎯 Next Features to Add

- [ ] Streams/Broadcasts (Video streaming)
- [ ] Marketplace listings and transactions
- [ ] Real-time chat messaging
- [ ] User profiles and following
- [ ] Payment integration

## 📞 Common Commands

```bash
# Clean build
xcodebuild -workspace ios/EroticLiveX.xcworkspace \
  -scheme EroticLiveX clean

# Build for simulator
xcodebuild -workspace ios/EroticLiveX.xcworkspace \
  -scheme EroticLiveX \
  -configuration Debug \
  -derivedDataPath ios/build

# Run tests
xcodebuild -workspace ios/EroticLiveX.xcworkspace \
  -scheme EroticLiveXTests
```

## 💡 Tips

- **Always use `.xcworkspace`** not `.xcodeproj`
- **Check console output** for Firebase initialization logs
- **Update CocoaPods regularly:** `pod repo update`
- **Verify permissions** in `Info.plist` for camera, mic, photo library

---

For detailed setup, see [IOS_SETUP.md](IOS_SETUP.md)
