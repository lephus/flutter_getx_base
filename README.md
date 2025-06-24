# S SMART MOBILE

Author: Phu Le
Email: phule9225@gmail.com

## Generate Locates / assets

```bash
get generate locales assets/locales
dart run build_runner build
```

## Run build_runner generate DI, model, route

```bash
$ flutter pub run build_runner build
$ flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Setting the splash screen

```bash
$ flutter pub run flutter_native_splash:create
```

## Rename app

```bash
$ flutter pub global run rename setBundleId --targets ios,android --value com.flutter.getx
$ flutter pub global run rename setAppName --targets ios,android --value  "Flutter GetX"
```

## Set launcher app icon (assets/icons/launcher/app_icon.png)

```bash
$ flutter pub get
$ flutter pub run flutter_launcher_icons
```

## Image dynamic

https://picsum.photos/200/300

# APP BUILD STEP

1. cd this project folder
2. flutter clean
3. delete files: "pubspec.lock", "ios/Pods", "ios/Podfile.lock"
4. flutter pub get
5. cd ios
6. pod install or arch -x86_64 pod install
7. Build on xcode

## Description:

## ngrok

- ngrok http PORT_NUMBER

Delete pod directory and podfile.lock
flutter clean
flutter pub get
cd ios
pod install --repo-update
pod update Firebase/Messaging
run the application in Xcode

flutter clean && flutter pub get && cd ios && pod install --repo-update && cd ..
flutter clean && flutter pub get && flutter build appbundle