import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulación de enlace público en la nube
    const String publicLink = 'https://prisma.app/video/12345';

    return Scaffold(
      appBar: AppBar(
        title: const Text('RESULTADO FINAL'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Preview del video/foto (simulado)
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFFFD700), width: 3),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_circle_outline, size: 100, color: Colors.white),
                        SizedBox(height: 20),
                        Text(
                          'PREVIEW DEL VIDEO',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '(En build nativo: video real + superposición)',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // QR grande
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: QrImageView(
                    data: publicLink,
                    version: QrVersions.auto,
                    size: 250.0,
                    gapless: false,
                    embeddedImage: const AssetImage('assets/LogoHome.gif'), // opcional: logo en centro del QR
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: const Size(60, 60),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  'Escanea para ver/descargar en la nube',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                      onPressed: () => context.go('/event-active'),
                      child: const Text('DESECHAR', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardado en galería local')));
                      },
                      child: const Text('GUARDAR', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enlace compartido: $publicLink')));
                      },
                      child: const Text('COMPARTIR', style: TextStyle(color: Colors.black, fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}