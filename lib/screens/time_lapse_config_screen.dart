import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TimeLapseConfigScreen extends StatefulWidget {
  const TimeLapseConfigScreen({super.key});

  @override
  State<TimeLapseConfigScreen> createState() => _TimeLapseConfigScreenState();
}

class _TimeLapseConfigScreenState extends State<TimeLapseConfigScreen> {
  String interval = '2';
  String duration = '30';
  String speed = '15';
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$type añadido')));
    }
  }

  void startEvent() {
    context.go('/event-active');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CONFIG TIME LAPSE')),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('AJUSTES TIME LAPSE', style: TextStyle(color: Color(0xFFFFD700), fontSize: 20, fontWeight: FontWeight.bold)),
              _picker('Intervalo entre fotos (seg)', interval, ['1', '2', '3', '5', '10'], (v) => setState(() => interval = v)),
              _picker('Duración total (seg)', duration, ['30', '60', '120', '300'], (v) => setState(() => duration = v)),
              _picker('Velocidad final', speed, ['8', '15', '30', '60'], (v) => setState(() => speed = v)),
              const SizedBox(height: 30),
              const Text('TUS ELEMENTOS', style: TextStyle(color: Color(0xFFFFD700), fontSize: 20, fontWeight: FontWeight.bold)),
              _assetGrid(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subida automática a la nube', style: TextStyle(color: Color(0xFFFFD700), fontSize: 18)),
                  Switch(value: autoUpload, onChanged: (v) => setState(() => autoUpload = v), activeThumbColor: const Color(0xFFFFD700)),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), padding: const EdgeInsets.symmetric(vertical: 22)),
                onPressed: startEvent,
                child: const Text('INICIAR EVENTO', style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold)),
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
        Text(label, style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(border: Border.all(color: const Color(0xFFFFD700)), borderRadius: BorderRadius.circular(12)),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: const Color(0xFF222222),
            style: const TextStyle(color: Colors.white),
            items: items.map((String item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
            onChanged: (v) => onChanged(v!),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _assetGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
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
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF111111), side: const BorderSide(color: Color(0xFFFFD700))),
      onPressed: () => pickAsset(type),
      child: Text('$label (${counts[type]})', style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
    );
  }
}