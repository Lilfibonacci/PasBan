<p align="center">
  <a href="README.md">🇺🇸 English</a> |
  <a href="README_FA.md">🇮🇷 فارسی</a>
</p>

# PasBan Authenticator 🛡️

A secure, modern, and open-source Two-Factor Authentication (2FA) application built with Flutter. PasBan generates Time-based One-Time Passwords (TOTP) to protect your online accounts, keeping your data strictly on your device with military-grade encryption.

## ✨ Features

* **QR Code Scanner:** Instantly add accounts by scanning standard 2FA QR codes.
* **Manual Entry:** Support for adding accounts via secret setup keys with built-in smart input correction.
* **Biometric Locking (Local Auth):** Secure app access using device-native Biometric Authentication (Fingerprint / Face ID) to prevent unauthorized access.
* **Dynamic 30-Second TOTP Generation:** Real-time 6-digit code generation that automatically regenerates every 30 seconds, paired with an intuitive, animated pie-chart countdown timer.
* **Multi-language Support:** Seamless localization supporting both English and Persian (RTL) layouts.
* **Theme Management:** Full support for custom Dark Mode, Light Mode, and System Theme preferences.
* **Secure Storage:** All accounts and secret keys are encrypted and safely stored using hardware-backed keystores (Keychain for iOS, Keystore for Android).
* **One-Tap Copy:** Quickly copy codes to your clipboard with a fluid, seamless UI/UX.
* **Account Management:** Easily remove accounts with a smooth "Swipe to Delete" gesture, complete with a destructive action confirmation dialog.
* **Offline by Design:** The app requires zero internet permissions, ensuring your cryptographic keys never leave your device.

## 🛠️ Tech Stack & Architecture

* **Framework:** Flutter / Dart
* **Architecture:** Clean Architecture (Data, Domain, Presentation layers)
* **State Management:** BLoC (Business Logic Component)
* **Routing:** GoRouter

### Key Packages
* `flutter_secure_storage`: For hardware-encrypted local key storage.
* `local_auth`: For system-level biometric integration (Fingerprint, Face ID, Passcode).
* `mobile_scanner`: For fast and reliable QR code camera detection.
* `otp`: For RFC 6238 standard TOTP algorithm implementation.
* `flutter_bloc`: For clean, predictable state handling.

## 📸 Screenshots
<img width="172" height="360" alt="Screenshot 2026-06-08 195938" src="https://github.com/user-attachments/assets/2bd5ffac-ad13-45a8-b972-b8a3ce8fefc6" />
 <img width="172" height="360" alt="Screenshot 2026-06-08 200003" src="https://github.com/user-attachments/assets/f31d9944-6c29-4dfd-8fe9-7c1fe1a08c67" />
<img width="172" height="360" alt="Screenshot 2026-06-08 200029" src="https://github.com/user-attachments/assets/3ba7ba5d-a79f-402c-aa27-44a1c861d488" />
<img width="172" height="360" alt="Screenshot 2026-06-08 200152" src="https://github.com/user-attachments/assets/bd0ac9c8-c573-4979-b5e0-386cd91955db" />
<img width="172" height="360" alt="Screenshot 2026-06-08 200242" src="https://github.com/user-attachments/assets/b66a89e7-3277-4059-9174-8089fd4011da" />

---

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
