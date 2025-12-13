import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'screens/event_management_screen.dart';
import 'screens/time_lapse_config_screen.dart';
import 'screens/slow_motion_config_screen.dart';
import 'screens/photo_config_screen.dart';
import 'screens/event_active_screen.dart';
import 'screens/capture_screen.dart';
import 'screens/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PRISMA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF000000),
        primaryColor: const Color(0xFFFFD700),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF000000),
          foregroundColor: Color(0xFFFFD700),
          elevation: 0,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFD700),
          ),
        ),
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'event-management',
          builder: (context, state) => const EventManagementScreen(),
        ),
        GoRoute(
          path: 'time-lapse-config',
          builder: (context, state) => const TimeLapseConfigScreen(),
        ),
        GoRoute(
          path: 'slow-motion-config',
          builder: (context, state) => const SlowMotionConfigScreen(),
        ),
        GoRoute(
          path: 'photo-config',
          builder: (context, state) => const PhotoConfigScreen(),
        ),
        GoRoute(
          path: 'event-active',
          builder: (context, state) => const EventActiveScreen(),
        ),
        GoRoute(
          path: 'capture',
          builder: (context, state) => const CaptureScreen(),
        ),
        GoRoute(
          path: 'result',
          builder: (context, state) => const ResultScreen(),
        ),
      ],
    ),
  ],
);