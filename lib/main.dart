import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/theme_config.dart';
import 'providers/auth_provider.dart';
import 'providers/profile_provider.dart';
import 'screens/auth/get_started_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/verification_screen.dart';
import 'screens/auth/change_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/main/main_screen.dart';
import 'services/api_service.dart';

void main() {
  // Initialize API service
  ApiService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        title: 'Swirlo',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.darkTheme,
        initialRoute: '/get-started',
        routes: {
          '/': (context) => const GetStartedScreen(),
          '/get-started': (context) => const GetStartedScreen(),
          '/splash': (context) => const SplashScreen(),
          '/signin': (context) => const LoginScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/verification': (context) => const VerificationScreen(),
          '/change-password': (context) => const ChangePasswordScreen(),
          '/home': (context) => const MainScreen(),
          '/main': (context) => const MainScreen(),
          '/dashboard': (context) => const MainScreen(initialIndex: 0),
          '/explore': (context) => const MainScreen(initialIndex: 1),
          '/messages': (context) => const MainScreen(initialIndex: 2),
          '/profile': (context) => const MainScreen(initialIndex: 3),
        },
      ),
    );
  }
}
