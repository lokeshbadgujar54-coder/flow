# Flutter Frontend Setup Guide

## Prerequisites
- Flutter SDK installed ([Download](https://flutter.dev/docs/get-started/install))
- Dart SDK (comes with Flutter)
- Android Studio or Xcode (for emulator)

## Installation Steps

### 1. Navigate to Frontend Directory
```bash
cd frontend
```

### 2. Get Dependencies
```bash
flutter pub get
```

### 3. Run App

**On Emulator:**
```bash
flutter run
```

**On Physical Device:**
```bash
flutter run -d <device-id>
```

**On Web:**
```bash
flutter run -d chrome
```

### 4. Update API Base URL
Edit `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'http://YOUR_SERVER_IP:8000/api';
```

## Project Structure

```
frontend/
├── lib/
│   ├── main.dart                 # Entry point
│   ├── providers/
│   │   └── auth_provider.dart    # State management
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   └── home/
│   │       └── home_screen.dart
│   └── services/
│       └── api_service.dart      # API calls
├── pubspec.yaml                  # Dependencies
└── README.md
```

## Key Dependencies

- **http**: Network requests
- **provider**: State management
- **shared_preferences**: Local storage
- **video_player**: Video playback
- **go_router**: Navigation
- **image_picker**: Image selection

## Features Implemented

### Authentication
- User registration (Student/Teacher)
- Login with JWT token
- Persistent login (SharedPreferences)
- Logout functionality

### Navigation
- GoRouter for page navigation
- Login → Register → Home flow
- Protected routes

### API Integration
- Login/Register endpoints
- Course listing
- Lesson fetching

## Building for Release

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Common Issues

**API Connection Failed:**
- Ensure backend is running
- Check firewall settings
- Update API base URL in code

**Gradle Build Error:**
```bash
flutter clean
flutter pub get
flutter run
```

**Hot Reload Not Working:**
```bash
flutter run --no-fast-start
```

## Next Steps

1. Add more screens (Courses, Assignments, etc.)
2. Implement video player
3. Add file upload functionality
4. Implement real-time notifications
5. Add chat/messaging feature
6. Setup payment integration
