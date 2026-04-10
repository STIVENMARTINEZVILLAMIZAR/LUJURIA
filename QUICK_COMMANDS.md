# ⚡ Comandos Rápidos - EroticLiveX

## 🚀 Backend (Java/Spring Boot)

```bash
# Compilar código
mvn clean compile

# Ejecutar tests
mvn test

# Compilar + Tests + Empaquetar
mvn clean package

# Ejecutar servidor
mvn spring-boot:run

# Servidor en: http://localhost:8080

# Limpiar todo
mvn clean
```

---

## 📱 Android (Kotlin)

```bash
cd android

# Sincronizar Gradle
./gradlew sync

# Construir app
./gradlew build

# Construir debug
./gradlew buildDebug

# Instalar en emulador
./gradlew installDebug

# Ejecutar tests
./gradlew test

# Limpiar build
./gradlew clean

# Abrir Android Studio
android-studio .
```

---

## 🍎 iOS (Swift)

```bash
cd ios

# Instalar pods
pod install

# Actualizar pods
pod update

# Abrir workspace en Xcode
open EroticLiveX.xcworkspace

# Compilar desde terminal
xcodebuild -workspace EroticLiveX.xcworkspace \
  -scheme EroticLiveX \
  -configuration Debug \
  clean build

# Ejecutar tests
xcodebuild -workspace EroticLiveX.xcworkspace \
  -scheme EroticLiveXTests \
  test

# Limpiar build
rm -rf build

# Limpiar pods
rm -rf Pods
rm Podfile.lock
pod install
```

---

## 🌐 Frontend (Vue/React)

```bash
cd frontend

# Instalar dependencias
npm install

# Ejecutar en desarrollo
npm run dev

# Acceder: http://localhost:5173

# Compilar para producción
npm run build

# Ver build producción
npm run preview

# Limpiar node_modules
rm -rf node_modules
npm install
```

---

## 🔥 Firebase Console

```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Ver proyectos
firebase projects:list

# Emuladores (local testing)
firebase emulators:start

# Desplegar (si tienes hosting)
firebase deploy

# Ver logs remotos
firebase functions:log
```

---

## 🐳 Docker (Opcional)

```bash
# Levantar servicios (MySQL, etc)
docker compose up -d

# Ver contenedores
docker compose ps

# Ver logs
docker compose logs -f

# Detener
docker compose down

# Limpiar todo
docker compose down -v
```

---

## 🔍 Verificación Rápida

```bash
# Tests pasando (Java)
mvn test && echo "✅ Java OK"

# Android compilando
cd android && ./gradlew build && echo "✅ Android OK"

# iOS compilando
cd ios && pod install && echo "✅ iOS OK"

# Frontend OK
cd frontend && npm install && npm run build && echo "✅ Frontend OK"
```

---

## 🐛 Debugging

### Backend (Java)
```bash
# Ejecutar con debug
mvn -Dmaven.surefire.debug clean test

# Ver logs en tiempo real
tail -f target/logs/app.log
```

### Android
```bash
# Ver logcat
adb logcat

# Filtrar logs
adb logcat | grep "MyApp"

# Limpiar cache app
adb shell pm clear com.company.eroticlivex
```

### iOS
```bash
# Ver device logs en Xcode
# Window → Device and Simulators → Select device → View logs

# Desde terminal
xcrun simctl list devices

# Abrir simulator
open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app
```

---

## 📊 Monitoreo

```bash
# Firebase Console aktividad
open https://console.firebase.google.com

# Firestore queries en tempo real
firebase emulators:start --import=./backup

# Logs remoto
firebase functions:log --follow

# Performance metrics
# Vé a Firebase Console → Performance → Monitor tab
```

---

## 🚨 Problemas Comunes

### "Gradle sync failed"
```bash
cd android
./gradlew clean
./gradlew --refresh-dependencies sync
```

### "Pod installation error"
```bash
cd ios
pod repo update
rm -rf Pods
rm Podfile.lock
pod install
```

### "Maven dependency error"
```bash
mvn clean
rm -rf ~/.m2/repository
mvn clean compile
```

### "Port already in use"
```bash
# Java (Puerto 8080)
lsof -i :8080
kill -9 <PID>

# Node (Puerto 5173)
lsof -i :5173
kill -9 <PID>
```

---

## 📝 Alias Útiles (Agrega a .bashrc o .zshrc)

```bash
alias mvnc='mvn clean compile'
alias mvnt='mvn test'
alias mvnr='mvn spring-boot:run'

alias adroid='cd android && ./gradlew build'
alias ios='cd ios && pod install && open EroticLiveX.xcworkspace'

alias frontend='cd frontend && npm run dev'

alias eroticlivex='cd ~/Documents/EroticLiveX'
```

---

## 🎯 Workflow típico de desarrollo

```bash
# 1. Empezar el día
cd ~/Documents/EroticLiveX
git pull origin main

# 2. Backend changes
mvn clean compile && mvn test

# 3. Android changes
cd android && ./gradlew build

# 4. iOS changes
cd ../ios && pod install && xcodebuild...

# 5. Frontend changes
cd ../frontend && npm run dev

# 6. Terminar
git add .
git commit -m "Feature: agregar descripción"
git push origin main
```

---

## ✅ Pre-commit Checklist

```bash
# 1. Tests pasando
mvn test

# 2. No hay errores de compilación
mvn clean compile

# 3. Android OK
cd android && ./gradlew build && cd ..

# 4. iOS OK
cd ios && pod install && cd ..

# 5. Frontend OK
cd frontend && npm run build && cd ..

# 6. Files formateados
# (Según tu IDE settings)

# 7. Commit!
git commit -m "descriptión breve"
```

---

## 🚀 Deployment

```bash
# Pre-deployment checks
mvn clean test
cd android && ./gradlew build && cd ..
cd ios && xcodebuild ... && cd ..
cd frontend && npm run build && cd ..

# Backend
mvn clean package
# Deploy JAR a producción

# Android
# Firmar APK y subir a Google Play Console

# iOS
# Archivary build y subir a App Store Connect

# Frontend
# Deploy a hosting (Vercel, Netlify, etc)
firebase deploy --only hosting
```

---

¡Guarda este archivo para referencia rápida! 📌
