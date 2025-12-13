import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF111111)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo GIF con fallback
              Image.asset(
                'assets/LogoHome.gif',
                width: 320,
                height: 320,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'PRISMA',
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD700),
                      letterSpacing: 4,
                    ),
                  );
                },
              ),
              const SizedBox(height: 80),
              _modeButton(context, 'TIME LAPSE', const Color(0xFF4CAF50)),
              _modeButton(context, 'SLOW MOTION', const Color(0xFF2196F3)),
              _modeButton(context, 'FOTOGRAFÍA', const Color(0xFF9C27B0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeButton(BuildContext context, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(320, 110),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 15,
          shadowColor: Colors.black.withOpacity(0.7),
        ),
        onPressed: () => context.go('/event-management'),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}