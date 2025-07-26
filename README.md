# 📋 Task Manager App – Flutter

A simple task management app for **gig workers**, built with **Flutter**, **Firebase**, and **Bloc**, as part of the internship assignment for **Whatbytes**.

---

## 🚀 Features

✅ User Authentication (Firebase – Email/Password)  
✅ Task CRUD: Create, Edit, Delete, View  
✅ Task Filtering by:
- **Priority**: Low, Medium, High
- **Status**: Completed / Incomplete  
✅ Firebase Firestore as backend  
✅ Bloc for authentication state management  
✅ Material 3 Design & Responsive UI  
✅ Clean Code Architecture  
✅ Compatible with Android & iOS

---

## 🏗️ Project Structure

```
lib/
├── bloc/                   # Bloc for user state management
│   ├── userbloack_bloc.dart
│   ├── userbloack_event.dart
│   └── userbloack_state.dart
├── card/
│   └── tasklist.dart       # Task card list UI
├── login/                  # Login and onboarding
│   ├── bloc/
│   │   ├── login_bloc.dart
│   │   ├── login_event.dart
│   │   └── login_state.dart
│   ├── login.dart
│   └── onboarding.dart
├── main_navigation/
│   ├── home.dart
│   ├── navigation.dart
│   ├── profile.dart
│   └── services.dart
├── model/
│   ├── taskmodel.dart
│   └── usermodel.dart
├── task/
│   ├── firebase_options.dart
│   ├── global.dart
│   └── send.dart
├── main.dart               # Entry point
```

## 📱 Screenshots

![b36379eb-2c4a-4837-8bcc-18b6cd658e4f](https://github.com/user-attachments/assets/54e48f9a-6011-4e10-bbe6-c07e06f910cb)
![4fed0d1c-bfc2-4244-87d0-b51845b2f64b](https://github.com/user-attachments/assets/08eb8996-15c8-46bf-80e4-12f28b713b8f)
![56ba6d81-44f5-4744-ae22-8de60ce0bc03](https://github.com/user-attachments/assets/fefbb835-aaec-4200-8de2-9397181e64d9)


---

## 🔧 Tech Stack

- **Flutter** (3.22.1)
- **Firebase Auth** & **Cloud Firestore**
- **Bloc** – Lightweight state management
- **Material Design 3**
- **Dart**

---

## 🧪 How to Run

1. **Clone the repository**

```bash
git clone https://github.com/Hariswar8018/WhatBytes-Demo-App.git
cd task_app
```
## Install dependencies

```
flutter pub get
```

## 🔑 Test Credentials
Email: ayusmansamasi@gmail.com

Password: 123456


## 📅 Development Timeline
✅ Morning Commit: Firebase Auth, Login UI, Bloc setup

✅ Afternoon Commit: Task creation, listing, filters

✅ Final Commit: Responsive UI, clean up, and README

---

### 📌 Notes
* Bloc is used for managing login and user state.

* For task operations, Firebase Auth UID was directly used as it was scoped and sufficient.

* If required, I'm open to refactoring to add a global user Bloc for consistency.

### 🙏 Acknowledgment
Thanks to Whatbytes for this opportunity to showcase and strengthen my Flutter development skills.
Looking forward to your feedback and next steps.
