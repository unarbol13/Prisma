import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SlowMotionConfigScreen extends StatefulWidget {
  const SlowMotionConfigScreen({super.key});

  @override
  State<SlowMotionConfigScreen> createState() => _SlowMotionConfigScreenState();
}

class _SlowMotionConfigScreenState extends State<SlowMotionConfigScreen> {
  String curve = 'bullet'; // 'full' o 'bullet'
  String duration = '15';
  bool autoUpload = true;

  final Map<String, int> counts = {'frames': 0, 'music': 0, 'stickers': 0, 'gifs': 0};

  Future<String> getAssetPath(String type) async {
    final dir = await getApplicationDocumentsDirectory();
    final assetDir = Directory('${dir.path}/user_assets/$type');
    if (!await assetDir.exists()) await assetDir.create(recursive: true);
    return assetDir.path;
  }

  Future<void> pickAsset(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      final path = await getAssetPath(type);
      final file = File(result.files.single.path!);
      await file.copy('$path/${result.files.single.name}');
      setState(() {
        counts[type] = counts[type]! + 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$type añadido')),
      );
    }
  }

  void startEvent() {
    context.go('/event-active');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIG SLOW MOTION'),
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'AJUSTES SLOW MOTION',
                style: TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _picker('Curva de velocidad', curve, ['Full Slow', 'Bullet (5-5-5)'], (v) => setState(() => curve = v == 'Full Slow' ? 'full' : 'bullet')),
              _picker('Duración del video (segundos)', duration, ['10', '15', '20', '30'], (v) => setState(() => duration = v)),

              const SizedBox(height: 30),
              const Text(
                'TUS ELEMENTOS',
                style: TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _assetGrid(),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Subida automática a la nube',
                    style: TextStyle(color: Color(0xFFFFD700), fontSize: 18),
                  ),
                  Switch(
                    value: autoUpload,
                    onChanged: (v) => setState(() => autoUpload = v),
                    activeColor: const Color(0xFFFFD700),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: startEvent,
                child: const Text(
                  'INICIAR EVENTO',
                  style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _picker(String label, String value, List<String> items, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFFD700)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: const Color(0xFF222222),
            style: const TextStyle(color: Colors.white),
            underline: Container(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(item),
                ),
              );
            }).toList(),
            onChanged: (v) => onChanged(v!),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _assetGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 2.5,
      children: [
        _assetButton('MARCOS', 'frames'),
        _assetButton('MÚSICA', 'music'),
        _assetButton('STICKERS', 'stickers'),
        _assetButton('GIFs', 'gifs'),
      ],
    );
  }

  Widget _assetButton(String label, String type) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF111111),
        side: const BorderSide(color: Color(0xFFFFD700), width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () => pickAsset(type),
      child: Text(
        '$label (${counts[type]})',
        style: const TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}