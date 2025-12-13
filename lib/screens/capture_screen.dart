import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  int? countdown;

  Future<void> startCountdown() async {
    setState(() {
      countdown = 3;
    });
    for (int i = 3; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          countdown = i - 1;
        });
      }
    }
    setState(() {
      countdown = null;
    });
    // Simulación de captura
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡CAPTURA SIMULADA! (En build nativo: grabación real + FFmpeg + stickers arrastrables)')),
    );
    // Navega a resultado (cuando lo tengamos)
    // context.go('/result');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Simulación de vista de cámara
          Container(
            color: Colors.black,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'Vista previa de cámara',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Stickers arrastrables y grabación real\nactivados en build nativo',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Contador 3-2-1 gigante
          if (countdown != null)
            Center(
              child: Text(
                '$countdown',
                style: const TextStyle(
                  fontSize: 140,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 0),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),

          // Botones inferiores
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.flip_camera_ios, size: 40, color: Colors.white),
                  onPressed: () {
                    // Simulación de cambio de cámara
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cámara cambiada (simulado)')),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                  ),
                  onPressed: startCountdown,
                  child: const Icon(Icons.camera, size: 40, color: Colors.black),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 40, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}