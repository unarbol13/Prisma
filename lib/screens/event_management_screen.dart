import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventManagementScreen extends StatefulWidget {
  const EventManagementScreen({super.key});

  @override
  State<EventManagementScreen> createState() => _EventManagementScreenState();
}

class _EventManagementScreenState extends State<EventManagementScreen> {
  List<Map<String, dynamic>> events = [];
  int selectedTab = 0; // 0 = en curso, 1 = pasados, 2 = crear

  @override
  void initState() {
    super.initState();
    // Simulación de eventos (más adelante con SharedPreferences)
    events = [
      {'id': '1', 'name': 'Boda Juan y María', 'host': 'Juan', 'isActive': true},
      {'id': '2', 'name': 'Cumpleaños Ana', 'host': 'Ana', 'isActive': false},
    ];
  }

  void createEvent() {
    TextEditingController nameController = TextEditingController();
    TextEditingController hostController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo Evento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre del evento'),
            ),
            TextField(
              controller: hostController,
              decoration: const InputDecoration(labelText: 'Anfitrión'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              String name = nameController.text.trim();
              String host = hostController.text.trim();
              if (name.isNotEmpty && host.isNotEmpty) {
                setState(() {
                  events.add({
                    'id': DateTime.now().toString(),
                    'name': name,
                    'host': host,
                    'isActive': true,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Evento "$name" creado')),
                );
                context.go('/time-lapse-config'); // Ejemplo, cambia según modo
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Completa todos los campos')),
                );
              }
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredEvents = selectedTab == 0
        ? events.where((e) => e['isActive']).toList()
        : events.where((e) => !e['isActive']).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('MIS EVENTOS')),
      body: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'EN CURSO'),
              Tab(text: 'PASADOS'),
              Tab(text: 'CREAR'),
            ],
            onTap: (index) => setState(() => selectedTab = index),
          ),
          Expanded(
            child: selectedTab == 2
                ? Center(
                    child: ElevatedButton(
                      onPressed: createEvent,
                      child: const Text('+ NUEVO EVENTO'),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return ListTile(
                        title: Text(event['name']),
                        subtitle: Text('Anfitrión: ${event['host']}'),
                        onTap: () {
                          if (event['isActive']) {
                            context.go('/time-lapse-config'); // Cambia según modo del evento
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Evento finalizado')),
                            );
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}