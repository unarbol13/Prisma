import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventActiveScreen extends StatefulWidget {
  const EventActiveScreen({super.key});

  @override
  State<EventActiveScreen> createState() => _EventActiveScreenState();
}

class _EventActiveScreenState extends State<EventActiveScreen> {
  bool isUploading = false;

  void _simulateUpload() {
    setState(() {
      isUploading = true;
    });
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isUploading = false;
        });
      }
    });
  }

  void _endEvent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Finalizar evento'),
        content: const Text('¿Estás seguro de que quieres cerrar este evento?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/event-management');
            },
            child: const Text('Finalizar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EVENTO EN CURSO'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'NOMBRE DEL EVENTO',
                style: TextStyle(color: Color(0xFFFFD700), fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Anfitrión: Nombre',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 40),

              // 4 botones grandes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _bigButton(Icons.camera_alt, 'CAPTURAR', () => context.go('/capture')),
                  const SizedBox(width: 20),
                  _bigButton(Icons.image, 'VER GALERÍA', () => context.go('/event-gallery')),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _bigButton(Icons.cloud_upload, 'PENDIENTES', _simulateUpload),
                  const SizedBox(width: 20),
                  _wifiIndicator(),
                ],
              ),

              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _endEvent,
                child: const Text(
                  'FINALIZAR EVENTO',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bigButton(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFD700),
        minimumSize: const Size(160, 160),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 15,
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.black),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _wifiIndicator() {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: isUploading ? 1.0 : 0.5,
          duration: const Duration(milliseconds: 500),
          child: Icon(
            Icons.wifi,
            size: 60,
            color: isUploading ? Colors.green : Colors.grey,
          ),
        ),
        Text(
          isUploading ? 'SUBIENDO...' : 'ESPERANDO',
          style: TextStyle(color: isUploading ? Colors.green : Colors.grey, fontSize: 16),
        ),
      ],
    );
  }
}