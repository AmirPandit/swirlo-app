<div align="center">

# 💕 Swirlo

### Modern Dating App Built with Flutter

A beautiful, feature-rich dating application with swipeable cards, matching system, and real-time chat functionality.

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

[Features](#-features) • [Screenshots](#-screenshots) • [Getting Started](#-getting-started) • [Architecture](#-architecture) • [API](#-api-integration)

</div>

---

## ✨ Features

### ✅ Implemented

#### 🔐 Authentication System
- **User Registration** - Email and password-based signup
- **Email Verification** - 6-digit verification code sent via email
- **Resend Code** - Request new verification code
- **Secure Login** - JWT-based authentication
- **Session Management** - Automatic token refresh
- **Secure Storage** - Encrypted local storage for tokens
- **Form Validation** - Real-time input validation

#### 🎨 User Interface
- **Swipeable Cards** - Tinder-style card swiping interface
- **Dashboard** - Discover new profiles with smooth animations
- **Explore Screen** - Browse user profiles in list view
- **Messages** - Chat interface with conversation previews
- **Profile Screen** - User profile with settings
- **Dark Theme** - Beautiful dark mode design matching Figma
- **Responsive Design** - Optimized for all screen sizes

#### 📱 User Experience
- **Smooth Animations** - Card swipe gestures and transitions
- **Loading States** - Visual feedback for all actions
- **Error Handling** - User-friendly error messages
- **Back Button Control** - Prevents navigation to auth after login
- **Bottom Navigation** - Easy access to all main features

#### 🔧 Technical Features
- **State Management** - Provider pattern for reactive UI
- **Backend Integration** - FastAPI REST API integration
- **Offline Support** - Local data persistence
- **Network Interceptors** - Automatic token injection
- **Generic Response Wrapper** - Standardized API responses
- **Code Generation** - JSON serialization with build_runner

### 🚧 Coming Soon

- **Profile Management** - Edit profile, upload photos, manage preferences
- **Matching System** - Mutual like detection and match notifications
- **Real-time Chat** - WebSocket-based instant messaging
- **Advanced Filters** - Distance, age range, and preference filters
- **Super Likes** - Stand out from the crowd
- **Undo Feature** - Take back your last swipe
- **Push Notifications** - Match and message alerts
- **Photo Verification** - Profile verification system
- **Report & Block** - Safety features

---

## 📱 Screenshots

<div align="center">

| Auth Screens | Main Screens |
|:---:|:---:|
| ![Login](docs/screenshots/login.png) | ![Dashboard](docs/screenshots/dashboard.png) |
| ![Sign Up](docs/screenshots/signup.png) | ![Explore](docs/screenshots/explore.png) |
| ![Verification](docs/screenshots/verification.png) | ![Messages](docs/screenshots/messages.png) |

</div>

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** 3.10 or higher
- **Dart SDK** 3.0 or higher
- **Android Studio** or **Xcode** (for iOS)
- **Git**
- **MongoDB** (for backend)
- **Python 3.8+** (for backend)

### Installation

#### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/swirlo.git
cd swirlo
```

#### 2. Install Flutter Dependencies

```bash
flutter pub get
```

#### 3. Generate Model Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 4. Configure Backend API

Edit `lib/config/api_config.dart`:

```dart
class ApiConfig {
  // For Android Emulator
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // For iOS Simulator
  // static const String baseUrl = 'http://localhost:8000/api';

  // For Production
  // static const String baseUrl = 'https://api.swirlo.com/api';
}
```

#### 5. Run the App

```bash
flutter run
```

---

## 🗄️ Backend Setup

The app requires a FastAPI backend server. Follow these steps:

### 1. Navigate to Backend Directory

```bash
cd ../swirlo_backend
```

### 2. Create Virtual Environment

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Configure Environment Variables

Create a `.env` file:

```env
# App Configuration
APP_NAME=Swirlo
DEBUG=True
ENVIRONMENT=development

# MongoDB Configuration
MONGO_HOST=localhost
MONGO_PORT=27017
MONGO_DB=swirlo
MONGO_USER=admin
MONGO_PASSWORD=password

# JWT Configuration
JWT_SECRET_KEY=your-super-secret-key-change-in-production
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

# Email Configuration
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password
```

### 5. Start MongoDB

```bash
# Windows
net start MongoDB

# macOS
brew services start mongodb-community

# Linux
sudo systemctl start mongod
```

### 6. Run Backend Server

```bash
uvicorn main:app --reload
```

The backend will be available at:
- **API**: http://localhost:8000
- **Swagger Docs**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

---

## 🏗️ Architecture

### Tech Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Flutter 3.10+ |
| **Language** | Dart 3.0+ |
| **State Management** | Provider |
| **HTTP Client** | Dio with Interceptors |
| **Secure Storage** | flutter_secure_storage |
| **JSON Serialization** | json_serializable + build_runner |
| **Backend** | FastAPI + MongoDB |
| **Authentication** | JWT (JSON Web Tokens) |

### Design Patterns

- **Repository Pattern** - Separation of data sources
- **Singleton Pattern** - ApiService, StorageService
- **Provider Pattern** - Reactive state management
- **Factory Pattern** - Model deserialization
- **Interceptor Pattern** - HTTP request/response handling

### Project Structure

```
swirlo/
├── lib/
│   ├── config/
│   │   ├── api_config.dart           # API endpoints
│   │   └── theme_config.dart         # App theme
│   │
│   ├── data/
│   │   └── dummy_users.dart          # Sample data
│   │
│   ├── models/
│   │   ├── user_model.dart           # User data model
│   │   ├── user_card_model.dart      # Profile card model
│   │   ├── profile_model.dart        # User profile
│   │   ├── auth_response_model.dart  # Auth responses
│   │   └── api_response_model.dart   # Generic wrapper
│   │
│   ├── providers/
│   │   ├── auth_provider.dart        # Auth state
│   │   └── profile_provider.dart     # Profile state
│   │
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── get_started_screen.dart
│   │   │   ├── splash_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── signup_screen.dart
│   │   │   ├── verification_screen.dart
│   │   │   ├── forgot_password_screen.dart
│   │   │   └── change_password_screen.dart
│   │   │
│   │   ├── main/
│   │   │   ├── main_screen.dart      # Bottom nav
│   │   │   ├── dashboard_screen.dart # Swipe cards
│   │   │   ├── explore_screen.dart   # User list
│   │   │   ├── messages_screen.dart  # Chats
│   │   │   └── profile_screen.dart   # User profile
│   │   │
│   │   └── home/
│   │       └── home_screen.dart
│   │
│   ├── services/
│   │   ├── api_service.dart          # HTTP client
│   │   ├── auth_service.dart         # Auth logic
│   │   ├── storage_service.dart      # Secure storage
│   │   └── profile_service.dart      # Profile API
│   │
│   ├── utils/
│   │   └── validators.dart           # Form validation
│   │
│   ├── widgets/
│   │   └── common/
│   │       ├── custom_text_field.dart
│   │       ├── custom_button.dart
│   │       ├── loading_indicator.dart
│   │       └── app_gradient_background.dart
│   │
│   └── main.dart                     # App entry point
│
├── assets/
│   └── images/
│       └── logo.png
│
├── test/
│   └── widget_test.dart
│
├── pubspec.yaml
└── README.md
```

---

## 🔌 API Integration

### Implemented Endpoints

#### Authentication

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/register` | User registration |
| `POST` | `/api/login` | User login |
| `POST` | `/api/verify` | Email verification |
| `POST` | `/api/resend_verification_code` | Resend code |
| `POST` | `/api/refresh_token` | Refresh JWT token |
| `POST` | `/api/forgot-password` | Password reset |
| `POST` | `/api/change-password` | Change password |

#### Profile

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/profile/me` | Get user profile |
| `PUT` | `/profile/me` | Update profile |
| `POST` | `/profile/photos` | Upload photo |
| `DELETE` | `/profile/photos/:id` | Delete photo |

### API Response Format

All responses follow this structure:

```json
{
  "code": 200,
  "message": "Success message",
  "data": { /* response data */ }
}
```

### Example Requests

#### Registration

```json
POST /api/register
{
  "email": "user@example.com",
  "password": "SecurePass123",
  "confirm_password": "SecurePass123"
}
```

#### Login

```json
POST /api/login
{
  "email": "user@example.com",
  "password": "SecurePass123"
}

Response:
{
  "code": 200,
  "message": "Login Success",
  "data": {
    "access_token": "eyJhbGc...",
    "refresh_token": "eyJhbGc...",
    "user_id": "507f1f77bcf86cd799439011",
    "token_type": "bearer"
  }
}
```

#### Verification

```json
POST /api/verify
{
  "email": "user@example.com",
  "verification_code": "123456"
}
```

---

## 🎨 Design

### Figma Design Files

Design assets are located in the `figma files/` directory:

- **Sign In** - Login screen design
- **Sign Up** - Registration screen design
- **Forgot Password** - Password recovery flow
- **Explore (Community)** - User discovery screens

### Color Palette

```dart
// Primary Colors
primary: #7B68EE      // Purple
secondary: #9D8DF1    // Light Purple
accent: #FF4D67       // Pink

// Background
background: #1E1E2E   // Dark Purple/Black
cardBackground: #2A2A3E

// Text
textPrimary: #FFFFFF
textSecondary: #9E9E9E
textHint: #6B6B6B
```

---

## 🧪 Testing

### Run Unit Tests

```bash
flutter test
```

### Run Integration Tests

```bash
flutter drive --target=test_driver/app.dart
```

### Code Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

---

## 📦 Building

### Android

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle (for Play Store)
flutter build appbundle --release
```

### iOS

```bash
# Debug Build
flutter build ios --debug

# Release Build
flutter build ios --release
```

---

## 🐛 Troubleshooting

### Common Issues

#### 1. "Unable to load asset" error

```bash
flutter clean
flutter pub get
flutter run
```

#### 2. Build errors after adding packages

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 3. API connection fails on Android

- Use `10.0.2.2` instead of `localhost` for Android emulator
- Check `api_config.dart` has correct base URL
- Ensure backend server is running

#### 4. Secure storage errors

- Check `android/app/build.gradle`: `minSdkVersion >= 18`
- For iOS, ensure proper entitlements

#### 5. NDK errors on Android

```bash
# Windows
rd /s "C:\Users\[Username]\AppData\Local\Android\sdk\ndk\[version]"

# macOS/Linux
rm -rf ~/Library/Android/sdk/ndk/[version]
```

Then run `flutter run` to auto-download fresh NDK.

#### 6. Hot reload not working

- Press `R` for hot restart (capital R)
- Or run `flutter run --hot` explicitly

---

## 🗺️ Roadmap

### Phase 1: Foundation ✅
- [x] Authentication system
- [x] User registration & login
- [x] Email verification
- [x] JWT token management
- [x] Secure storage
- [x] Basic UI screens

### Phase 2: Core Features ✅
- [x] Dashboard with swipeable cards
- [x] Explore screen with user list
- [x] Messages screen UI
- [x] Profile screen
- [x] Dark theme
- [x] Bottom navigation

### Phase 3: User Profiles 🚧
- [ ] Profile creation/editing
- [ ] Photo upload (multiple images)
- [ ] Bio and interests
- [ ] Location settings
- [ ] Preference management

### Phase 4: Matching System 📋
- [ ] Like/Pass functionality
- [ ] Match detection
- [ ] Match notifications
- [ ] Match list screen
- [ ] Undo last swipe

### Phase 5: Messaging 📋
- [ ] Real-time chat (WebSocket)
- [ ] Message history
- [ ] Photo sharing
- [ ] Typing indicators
- [ ] Read receipts
- [ ] Push notifications

### Phase 6: Discovery 📋
- [ ] Distance filter
- [ ] Age range filter
- [ ] Gender preference
- [ ] Advanced search
- [ ] Discovery settings

### Phase 7: Polish & Launch 📋
- [ ] Super likes
- [ ] Profile verification
- [ ] Report & block users
- [ ] Analytics integration
- [ ] Performance optimization
- [ ] App Store deployment

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

### Code Style

- Follow [Flutter style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable names
- Add comments for complex logic
- Write tests for new features

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- FastAPI for the backend framework
- Unsplash for placeholder images
- The open-source community

---

## 📞 Support

For support, questions, or feedback:

- **Email**: support@swirlo.com
- **GitHub Issues**: [Create an issue](https://github.com/yourusername/swirlo/issues)
- **Documentation**: [Wiki](https://github.com/yourusername/swirlo/wiki)

---

<div align="center">

### ⭐ Star this repo if you find it helpful!

**Built with ❤️ using Flutter**

[Back to Top](#-swirlo)

</div>
