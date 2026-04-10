# 📱 iOS Setup Guide - EroticLiveX

## 📋 Prerequisites

- **Xcode 15+** (available on macOS)
- **CocoaPods 1.13+** installed
- **iOS 14.0+** deployment target
- **Apple Developer Account** (for signing and running on physical devices)

## ⚙️ Installation Steps

### 1. Install CocoaPods Dependencies

Navigate to the iOS project directory and install pods:

```bash
cd ios
pod install
```

If you need to update pods:

```bash
pod update
```

After installation, open the `.xcworkspace` file (NOT the `.xcodeproj`):

```bash
open EroticLiveX.xcworkspace
```

### 2. Configure GoogleService-Info.plist

The `GoogleService-Info.plist` is already included in the project:

- **Location:** `ios/EroticLiveX/GoogleService-Info.plist`
- **Content:** Firebase configuration with credentials
- **Bundle ID:** `com.company.EroticLiveX`

✅ **Already configured for you!**

### 3. Update Bundle Identifier (Optional)

If you want to change the bundle identifier:

1. Open `EroticLiveX.xcworkspace` in Xcode
2. Select the `EroticLiveX` project in the navigator
3. Select the `EroticLiveX` target
4. Go to **General** tab
5. Change the **Bundle Identifier**
6. Update `Info.plist` if needed

### 4. Build & Run

#### Simulator:

```bash
xcodebuild -workspace ios/EroticLiveX.xcworkspace -scheme EroticLiveX -configuration Debug -derivedDataPath ios/build
```

Or in Xcode:
- Select a simulator from the device dropdown
- Press **Cmd + R** or click **Play**

#### Physical Device:

1. Connect your iPhone/iPad
2. Select it from the device dropdown
3. Press **Cmd + R**
4. Trust the app on your device

## 🔐 Firebase Configuration

Firebase services are already configured:

- ✅ **Authentication (Sign Up/Sign In)**
- ✅ **Cloud Firestore (Database)**
- ✅ **Cloud Storage (Media)**
- ✅ **Cloud Messaging (Push Notifications)**
- ✅ **Real-time Database**
- ✅ **Performance Monitoring**
- ✅ **Google Analytics for Firebase**

## 📲 Push Notifications

The app automatically:

1. Requests user permission for notifications
2. Registers for push notifications
3. Handles incoming FCM messages
4. Displays notifications when the app is open

**Note:** Ensure you have the APNs certificate configured in Firebase Console.

## 🗂️ Project Structure

```
ios/
├── EroticLiveX/                          # Main app
│   ├── EroticLiveXApp.swift             # App entry point & AppDelegate
│   ├── Views/
│   │   ├── ContentView.swift            # Main UI & Tab navigation
│   │   └── AuthView.swift               # Authentication UI
│   ├── Services/
│   │   ├── FirebaseAuthManager.swift    # Authentication service
│   │   └── FirebaseFirestoreManager.swift # Database operations
│   ├── Models/
│   │   └── Models.swift                 # Data models
│   ├── Utils/                           # Utilities (add as needed)
│   ├── GoogleService-Info.plist         # Firebase configuration
│   └── Info.plist                       # App configuration
├── Podfile                              # CocoaPods dependencies
└── EroticLiveXTests/                    # Unit tests

```

## 🚀 Key Features Implemented

### Authentication (`FirebaseAuthManager.swift`)
- Sign up with email/password
- Sign in with email/password
- Sign out
- Send email verification
- Password reset
- Real-time auth state listener

### Database (`FirebaseFirestoreManager.swift`)
- Create user documents
- Read user data
- Update user profile
- Delete user data
- Listen to real-time updates

### UI Components
- **ContentView.swift:** Main TabView with 5 tabs (Home, Streams, Marketplace, Messages, Profile)
- **AuthView.swift:** Login/Registration form with error handling
- **Integration:** Authentication state automatically switches between AuthView and MainTabView

## 🔧 Building & Testing

### Build for Development:

```bash
xcodebuild -workspace ios/EroticLiveX.xcworkspace \
  -scheme EroticLiveX \
  -configuration Debug \
  -derivedDataPath ios/build
```

### Run Tests:

```bash
xcodebuild -workspace ios/EroticLiveX.xcworkspace \
  -scheme EroticLiveXTests \
  -configuration Debug
```

### Build for Release:

```bash
xcodebuild -workspace ios/EroticLiveX.xcworkspace \
  -scheme EroticLiveX \
  -configuration Release \
  -derivedDataPath ios/build
```

## 📝 Environment Configuration

All key configurations are in:
- **Info.plist** - App permissions, background modes
- **GoogleService-Info.plist** - Firebase settings
- **Podfile** - Dependency versions

## 🆘 Troubleshooting

### Pod installation fails:

```bash
pod repo update
pod install
```

### Build errors after pod install:

1. Clean the build folder: **Cmd + Shift + K**
2. Close Xcode
3. Delete `Pods` folder: `rm -rf Pods`
4. Delete lock file: `rm Podfile.lock`
5. Run `pod install` again

### Firebase not initializing:

- Verify `GoogleService-Info.plist` is in the Xcode project
- Build Phases tab → Copy Bundle Resources → Check `GoogleService-Info.plist` is included
- Clean build folder and rebuild

### Notifications not working:

- Check `Info.plist` has `UIBackgroundModes` with `remote-notification`
- Verify APNs certificate in Firebase Console
- Check device has notifications enabled for the app

## 📚 Additional Resources

- [Firebase iOS Documentation](https://firebase.google.com/docs/ios/setup)
- [SwiftUI Official Docs](https://developer.apple.com/tutorials/swiftui)
- [CocoaPods Guide](https://guides.cocoapods.org/)

## ✅ Checklist

- [ ] CocoaPods installed (`pod --version`)
- [ ] `pod install` completed successfully
- [ ] `GoogleService-Info.plist` present in project
- [ ] Bundle identifier matches Firebase project
- [ ] Xcode can build the project
- [ ] App launches in simulator
- [ ] Authentication screens appear
- [ ] Firebase initialization logs show in console

---

**Next Steps:**
1. Run `pod install` in the `ios` directory
2. Open `EroticLiveX.xcworkspace` in Xcode
3. Build and run on simulator or device
4. Test authentication flow
5. Monitor Firebase Console for activity
