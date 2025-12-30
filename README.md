# Swirlo - Tinder-like Dating App

A Flutter-based dating application with swipe gestures, matching, and real-time chat functionality.

## Table of Contents
- [Features](#features)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Building Features](#building-features)
- [API Integration](#api-integration)
- [Figma Design](#figma-design)
- [Development Roadmap](#development-roadmap)

## Features

### ✅ Implemented
- **Authentication System**
  - User registration with email/password
  - Email verification with 6-digit code
  - Resend verification code functionality
  - JWT-based authentication with FastAPI backend
  - Secure token storage (Flutter Secure Storage)
  - Automatic token refresh on 401 errors
  - Login/Logout flow
  - Session persistence
  - User data stored locally after login

- **State Management**
  - Provider pattern for reactive UI
  - Centralized auth state management
  - Loading and error states

- **Backend Integration**
  - Connected to FastAPI backend
  - Generic response wrapper handling
  - Error handling with user-friendly messages
  - Network request interceptors

- **Reusable Components**
  - Custom text fields with validation
  - Custom buttons with loading states
  - Themed UI components
  - Loading indicators

### 🚧 To Be Implemented
- **Profile Management**
  - User profile creation/editing
  - Photo upload (multiple photos)
  - Bio, interests, preferences
  - Age, location, gender settings

- **Card Swiping**
  - Tinder-style card stack
  - Swipe gestures (right = like, left = pass, up = super like)
  - Smooth animations
  - Undo last swipe

- **Matching System**
  - Real-time match notifications
  - Match list screen
  - Mutual like detection

- **Chat Feature**
  - One-on-one messaging with matches
  - Real-time message delivery
  - Read receipts
  - Typing indicators
  - Photo sharing in chat

- **Discovery Settings**
  - Distance radius filter
  - Age range filter
  - Gender preference
  - Show me on app toggle

## Architecture

### Tech Stack
- **Frontend**: Flutter 3.x
- **State Management**: Provider
- **HTTP Client**: Dio (with interceptors)
- **Secure Storage**: flutter_secure_storage
- **Serialization**: json_serializable + build_runner

### Design Patterns
- **Repository Pattern**: Separation of data sources and business logic
- **Singleton Pattern**: ApiService, StorageService
- **Provider Pattern**: State management
- **Factory Pattern**: Model deserialization

### Current Project Structure
```
swirlo/
├── lib/
│   ├── config/
│   │   ├── api_config.dart          # API endpoints & base URL
│   │   └── theme_config.dart        # App-wide theme (dark mode)
│   ├── models/
│   │   ├── user_model.dart          # User data model
│   │   ├── auth_response_model.dart # Auth API response
│   │   └── api_response_model.dart  # Generic API wrapper
│   ├── services/
│   │   ├── storage_service.dart     # Secure local storage
│   │   ├── api_service.dart         # HTTP client with JWT & interceptors
│   │   └── auth_service.dart        # Authentication logic
│   ├── providers/
│   │   └── auth_provider.dart       # Auth state management
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── get_started_screen.dart   # Welcome screen
│   │   │   ├── splash_screen.dart        # Initial loading
│   │   │   ├── login_screen.dart         # Login page
│   │   │   ├── signup_screen.dart        # Registration page
│   │   │   ├── verification_screen.dart  # Email verification
│   │   │   ├── forgot_password_screen.dart
│   │   │   └── change_password_screen.dart
│   │   └── home/
│   │       └── home_screen.dart          # Main authenticated screen
│   ├── widgets/common/
│   │   ├── custom_text_field.dart   # Reusable input field
│   │   ├── custom_button.dart       # Reusable button
│   │   └── loading_indicator.dart   # Loading UI
│   ├── utils/
│   │   └── validators.dart          # Form validation
│   └── main.dart                    # App entry point
├── pubspec.yaml
└── README.md
```

## Getting Started

### Prerequisites
- Flutter SDK 3.x or higher
- Android Studio / Xcode (for iOS)
- Android SDK / iOS SDK
- A running backend API (see [API Integration](#api-integration))

### Installation

1. **Navigate to project directory**
   ```bash
   cd "C:\Learning Projects\flutter app\swirlo"
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate model code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Configure backend API**

   Edit `lib/config/api_config.dart`:
   ```dart
   // For Android Emulator local development
   static const String baseUrl = 'http://10.0.2.2:8000/api';

   // For iOS Simulator
   // static const String baseUrl = 'http://localhost:8000/api';

   // For production
   // static const String baseUrl = 'https://api.swirlo.com/api';
   ```

   **Note:** The backend runs on port 8000 (FastAPI default)

5. **Run the app**
   ```bash
   flutter run
   ```

### First Time Setup Issues

**NDK Error on Android:**
If you encounter NDK errors, delete the corrupted NDK folder:
```bash
rm -rf "C:\Users\[YourUsername]\AppData\Local\Android\sdk\ndk\[version]"
```
Then run `flutter run` again to auto-download fresh NDK.

## Running the Backend

The Flutter app requires the FastAPI backend to be running. Follow these steps:

### Backend Setup

1. **Navigate to backend directory**
   ```bash
   cd "../swirlo_backend"
   ```

2. **Create and activate virtual environment**
   ```bash
   # Windows
   python -m venv venv
   venv\Scripts\activate

   # macOS/Linux
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure environment variables**

   Create a `.env` file in the backend directory:
   ```env
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
   JWT_SECRET_KEY=your-secret-key-change-in-production
   JWT_ALGORITHM=HS256
   ACCESS_TOKEN_EXPIRE_MINUTES=30
   REFRESH_TOKEN_EXPIRE_DAYS=7
   ```

5. **Start MongoDB**

   Make sure MongoDB is running on your machine:
   ```bash
   # Windows (if installed as service)
   net start MongoDB

   # macOS (if installed via Homebrew)
   brew services start mongodb-community

   # Linux
   sudo systemctl start mongod
   ```

6. **Run the backend server**
   ```bash
   uvicorn main:app --reload
   ```

   The backend will be available at:
   - API: `http://localhost:8000`
   - Swagger Docs: `http://localhost:8000/docs`
   - ReDoc: `http://localhost:8000/redoc`

### Email Configuration

The backend sends verification codes via email. Configure email settings in the backend:

1. Update email configuration in `swirlo_backend/utils/helpers/mail_sender.py`
2. Use a service like SendGrid, AWS SES, or Gmail SMTP
3. For development, emails will be logged to console if email service is not configured

## Building Features

### 1. Profile Management

#### Step 1: Create Profile Model
Create `lib/models/profile_model.dart`:
```dart
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String id;
  final String name;
  final int age;
  final String bio;
  final List<String> photos;
  final String location;
  final List<String> interests;
  final int distance; // in km

  ProfileModel({
    required this.id,
    required this.name,
    required this.age,
    required this.bio,
    required this.photos,
    required this.location,
    required this.interests,
    required this.distance,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
```

Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Step 2: Create Profile Service
Create `lib/services/profile_service.dart`:
```dart
class ProfileService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<ProfileModel>> getMyProfile() async {
    // GET /profile/me
  }

  Future<ApiResponse<ProfileModel>> updateProfile(ProfileModel profile) async {
    // PUT /profile/me
  }

  Future<ApiResponse<String>> uploadPhoto(File photo) async {
    // POST /profile/photos
  }
}
```

#### Step 3: Create Profile Provider
Create `lib/providers/profile_provider.dart` following the pattern in `auth_provider.dart`

#### Step 4: Create Profile Edit Screen
Create `lib/screens/profile/edit_profile_screen.dart` with form fields for name, bio, interests, etc.

### 2. Card Swiping Feature

#### Dependencies
Add to `pubspec.yaml`:
```yaml
dependencies:
  flutter_card_swiper: ^7.0.0  # Or appinio_swiper: ^2.0.0
```

#### Step 1: Create Card Stack Widget
Create `lib/widgets/swipe/profile_card.dart`:
```dart
class ProfileCard extends StatelessWidget {
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
        ],
      ),
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              profile.photos.first,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // Profile info
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile.name}, ${profile.age}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${profile.distance} km away',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  profile.bio,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

#### Step 2: Create Swipe Screen
Create `lib/screens/swipe/swipe_screen.dart`:
```dart
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipeScreen extends StatefulWidget {
  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final CardSwiperController controller = CardSwiperController();
  List<ProfileModel> profiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Card stack
            Expanded(
              child: CardSwiper(
                controller: controller,
                cardsCount: profiles.length,
                onSwipe: _onSwipe,
                cardBuilder: (context, index, _, __) {
                  return ProfileCard(profile: profiles[index]);
                },
              ),
            ),

            // Action buttons
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.close,
                    color: Colors.red,
                    onTap: () => controller.swipe(CardSwiperDirection.left),
                  ),
                  _buildActionButton(
                    icon: Icons.star,
                    color: Colors.blue,
                    onTap: () => controller.swipe(CardSwiperDirection.top),
                  ),
                  _buildActionButton(
                    icon: Icons.favorite,
                    color: Colors.green,
                    onTap: () => controller.swipe(CardSwiperDirection.right),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(int index, CardSwiperDirection direction) {
    // Handle swipe action
    if (direction == CardSwiperDirection.right) {
      // Like action - send to backend
      _likeProfile(profiles[index].id);
    } else if (direction == CardSwiperDirection.left) {
      // Pass action
      _passProfile(profiles[index].id);
    }
    return true;
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}
```

### 3. Matching System

#### Step 1: Create Match Model
```dart
class MatchModel {
  final String id;
  final ProfileModel profile;
  final DateTime matchedAt;
  final String? lastMessage;
  final DateTime? lastMessageAt;

  // ... constructor and serialization
}
```

#### Step 2: Create Match Service
```dart
class MatchService {
  Future<ApiResponse<List<MatchModel>>> getMatches() async {
    // GET /matches
  }

  Future<ApiResponse<bool>> likeProfile(String profileId) async {
    // POST /likes/{profileId}
  }
}
```

#### Step 3: Show Match Dialog
```dart
void _showMatchDialog(ProfileModel profile) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("It's a Match!", style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profile.photos.first),
          ),
          SizedBox(height: 20),
          Text('You and ${profile.name} liked each other!'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to chat
            },
            child: Text('Send Message'),
          ),
        ],
      ),
    ),
  );
}
```

### 4. Chat Feature

#### Dependencies
Add to `pubspec.yaml`:
```yaml
dependencies:
  socket_io_client: ^2.0.3  # For real-time messaging
  image_picker: ^1.0.7      # For photo sharing
```

#### Step 1: Create Message Model
```dart
class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type; // text, images
  final DateTime timestamp;
  final bool isRead;

  // ... constructor and serialization
}

enum MessageType { text, image }
```

#### Step 2: Create Chat Service
```dart
class ChatService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://your-api.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
  }

  void sendMessage(String matchId, String message) {
    socket.emit('message', {
      'matchId': matchId,
      'message': message,
    });
  }

  void onMessageReceived(Function(MessageModel) callback) {
    socket.on('new_message', (data) {
      callback(MessageModel.fromJson(data));
    });
  }
}
```

#### Step 3: Create Chat Screen
Create `lib/screens/chat/chat_screen.dart` with:
- Message list (ListView)
- Input field with send button
- Image picker for photo sharing
- Typing indicators

### 5. Bottom Navigation

Replace `home_screen.dart` with a bottom navigation structure:

```dart
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    SwipeScreen(),      // Main card swiping
    MatchesScreen(),    // List of matches
    MessagesScreen(),   // Chat conversations
    ProfileScreen(),    // User profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

## API Integration

The Flutter app integrates with a FastAPI backend located at `../swirlo_backend/`.

### Authentication Flow

1. **Registration:**
   - User registers with email and password
   - Backend sends 6-digit verification code to email
   - User must verify email before login

2. **Email Verification:**
   - User enters 6-digit code received via email
   - Backend verifies code and activates account
   - Can request code resend if not received

3. **Login:**
   - Only verified users can login
   - Backend returns JWT access and refresh tokens
   - Tokens stored securely using Flutter Secure Storage

4. **Automatic Token Refresh:**
   - On 401 error, app automatically attempts to refresh token
   - If refresh fails, user is logged out

### Implemented Backend Endpoints

#### Authentication
- `POST /api/register` - User registration
- `POST /api/login` - User login
- `POST /api/verify` - Email verification with code
- `POST /api/resend_verification_code` - Resend verification code
- `POST /api/refresh_token` - Refresh access token

#### Profile
- `GET /profile/me` - Get my profile
- `PUT /profile/me` - Update my profile
- `POST /profile/photos` - Upload photo
- `DELETE /profile/photos/:id` - Delete photo

#### Discovery
- `GET /discovery/profiles` - Get profiles to swipe (with filters)
- `POST /likes/:profileId` - Like a profile
- `POST /pass/:profileId` - Pass a profile

#### Matching
- `GET /matches` - Get all matches
- `POST /matches/:matchId/unmatch` - Unmatch

#### Chat
- `GET /messages/:matchId` - Get chat history
- `POST /messages/:matchId` - Send message
- WebSocket: `ws://your-api.com/chat` - Real-time messaging

### API Response Format

All backend responses follow this generic wrapper format:
```json
{
  "code": 200,
  "message": "Success message",
  "data": { /* actual response data */ }
}
```

#### Registration Request & Response

**Request:**
```json
{
  "email": "user@example.com",
  "password": "SecurePass123",
  "confirm_password": "SecurePass123"
}
```

**Response:**
```json
{
  "code": 201,
  "message": "User registered successfully",
  "data": {
    "email": "user@example.com",
    "is_verified": false,
    "is_active": false
  }
}
```

#### Verification Request & Response

**Request:**
```json
{
  "email": "user@example.com",
  "verification_code": "123456"
}
```

**Response:**
```json
{
  "code": 200,
  "message": "Account Verified Successfully",
  "data": {
    "email": "user@example.com",
    "is_verified": true,
    "is_active": true
  }
}
```

#### Login Request & Response

**Request:**
```json
{
  "email": "user@example.com",
  "password": "SecurePass123"
}
```

**Response:**
```json
{
  "code": 200,
  "message": "Login Success",
  "data": {
    "access_token": "eyJhbGc...",
    "refresh_token": "eyJhbGc...",
    "user_id": "507f1f77bcf86cd799439011",
    "token_type": "bearer",
    "is_verified": true,
    "is_active": true
  }
}
```

#### Refresh Token Request & Response

**Request:**
```json
{
  "refresh_token": "eyJhbGc..."
}
```

**Response:**
```json
{
  "access_token": "eyJhbGc...",
  "token_type": "bearer"
}
```

#### Error Response Format

```json
{
  "detail": "Error message" // or
  "detail": {
    "message": "Error message",
    "is_verified": false
  }
}
```

## Figma Design

### Design File
[Figma Design Link](https://www.figma.com/design/OBNVn3j6UwAZ5osyuGLi0i/Untitled?node-id=0-1&p=f&t=ZvS31zHHACGFtgpR-0)

**Note:** The Figma file is currently private. To implement the design:
1. Share the Figma file publicly, or
2. Export design assets (colors, spacing, typography, icons)
3. Provide screenshots of key screens

### Extracting Design Tokens from Figma

Once you have access, extract:

#### Colors
Update `lib/config/theme_config.dart`:
```dart
class AppColors {
  static const primary = Color(0xFFFF5864);      // Tinder red
  static const secondary = Color(0xFFFE3C72);    // Pink
  static const accent = Color(0xFF01E4CA);       // Teal
  static const background = Color(0xFFF8F8F8);   // Light gray
  static const cardBackground = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF424242);
  static const textSecondary = Color(0xFF757575);
}
```

#### Typography
```dart
class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const body1 = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  // ... more text styles
}
```

#### Spacing
```dart
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}
```

### How to Export from Figma

1. **Export Colors:**
   - Select any element with your color
   - Copy the hex color code from the right panel
   - Add to `AppColors` class

2. **Export Typography:**
   - Select text elements
   - Note font family, size, weight
   - Add to `AppTextStyles` class

3. **Export Assets:**
   - Select icons/images
   - Right-click → Export
   - Choose SVG for icons, PNG for images
   - Save to `assets/icons/` or `assets/images/`

4. **Export Spacing:**
   - Measure gaps between elements
   - Define consistent spacing values

## Development Roadmap

### Phase 1: Core Features (Week 1-2)
- [x] Authentication system
- [ ] Profile management
- [ ] Profile photo upload
- [ ] User preferences

### Phase 2: Swiping & Matching (Week 3-4)
- [ ] Card swipe UI
- [ ] Like/Pass functionality
- [ ] Match detection
- [ ] Match notifications
- [ ] Match list screen

### Phase 3: Messaging (Week 5-6)
- [ ] Chat UI
- [ ] Real-time messaging (WebSocket)
- [ ] Message history
- [ ] Photo sharing in chat
- [ ] Typing indicators
- [ ] Read receipts

### Phase 4: Discovery & Filters (Week 7)
- [ ] Distance filter
- [ ] Age range filter
- [ ] Gender preference
- [ ] Discovery settings screen

### Phase 5: Polish & Features (Week 8+)
- [ ] Super likes
- [ ] Undo last swipe
- [ ] Profile verification
- [ ] Report & block users
- [ ] Push notifications
- [ ] Animations & transitions
- [ ] Loading states
- [ ] Error handling

## Testing

### Run Tests
```bash
flutter test
```

### Widget Testing
Create test files in `test/` directory following Flutter testing conventions.

### Integration Testing
```bash
flutter drive --target=test_driver/app.dart
```

## Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Troubleshooting

### Common Issues

**1. "Unable to load asset" error**
- Run `flutter clean && flutter pub get`

**2. Build errors after adding packages**
- Run `flutter pub run build_runner build --delete-conflicting-outputs`

**3. Hot reload not working**
- Press `R` for hot restart instead of `r`

**4. API connection fails on Android**
- Use `10.0.2.2` instead of `localhost` for emulator
- Check `api_config.dart` has correct URL

**5. Secure storage errors**
- Check Android minSdkVersion is 18 or higher
- For iOS, ensure proper entitlements

**6. NDK errors on Android**
- Delete corrupted NDK: `rm -rf C:\Users\[User]\AppData\Local\Android\sdk\ndk\[version]`
- Gradle will auto-download fresh NDK on next build

## Performance Tips

1. **Image Optimization**
   - Use cached network images
   - Implement lazy loading for profile cards
   - Compress uploaded photos

2. **State Management**
   - Use `const` constructors where possible
   - Avoid unnecessary rebuilds with `Consumer` and `Selector`

3. **Network Requests**
   - Cache profile data locally
   - Implement pagination for lists
   - Use debouncing for search

## Contributing

1. Create a feature branch
2. Make your changes
3. Run tests
4. Submit a pull request

## License

MIT License

## Support

For issues or questions:
- Create an issue on GitHub
- Email: support@swirlo.com

---

**Built with ❤️ using Flutter**
#   s w i r l o  
 #   s w i r l o - a p p  
 