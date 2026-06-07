<a id="english-version"></a>

# PasBan Authenticator 🛡️

[**🇮🇷  نسخه فارسی (Persian Version)**](#persian-version)

A secure, modern, and open-source Two-Factor Authentication (2FA) application built with Flutter. PasBan generates Time-based One-Time Passwords (TOTP) to protect your online accounts, keeping your data strictly on your device with military-grade encryption.

## ✨ Features
* **QR Code Scanner:** Instantly add accounts by scanning standard 2FA QR codes.
* **Manual Entry:** Support for adding accounts via secret setup keys.
* **Secure Storage:** All accounts and secret keys are encrypted and stored safely using device-native keystores (Keychain for iOS, Keystore for Android).
* **Live TOTP Generation:** Real-time 6-digit code generation with a beautiful, animated pie-chart timer.
* **One-Tap Copy:** Quickly copy codes to your clipboard with a seamless UI/UX.
* **Dark/Light Mode:** Full support for system-wide themes.
* **Offline by Design:** The app requires zero internet permissions, ensuring your keys never leave your device.

## 🛠️ Tech Stack & Architecture
* **Framework:** Flutter / Dart
* **Architecture:** Clean Architecture
* **State Management:** BLoC (Business Logic Component)
* **Routing:** GoRouter
* **Key Packages:**
  * `flutter_secure_storage`: For encrypted local storage.
  * `mobile_scanner`: For fast and reliable QR code detection.
  * `otp`: For standard TOTP algorithm implementation.

## 🚀 Getting Started
To clone and run this application, you'll need Git and Flutter installed on your computer.

```bash
# Clone this repository
$ git clone [https://github.com/Lilfibonacci/PasBan.git](https://github.com/Lilfibonacci/PasBan.git)

# Go into the repository
$ cd PasBan

# Install dependencies
$ flutter pub get

# Run the app
$ flutter run
```
## 📥 Download
You can download the latest release (APK) directly from the Releases page.

## 🤝 Contributing
Contributions are always welcome!

Fork the project

Create your feature branch (git checkout -b feature/AmazingFeature)

Commit your changes (git commit -m 'Add some AmazingFeature')

Push to the branch (git push origin feature/AmazingFeature)

Open a Pull Request

## 📄 License
This project is distributed under the MIT License. See LICENSE for more information.

## ❤️ Final Note
PasBan aims to provide a reliable and secure 2FA solution, ensuring your digital identity remains safe and accessible even in the most challenging network conditions.
