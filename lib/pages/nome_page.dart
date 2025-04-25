import 'package:flutter/material.dart';

class NomePage extends StatelessWidget {
  const NomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> acrostico = [
      {'letra': 'L', 'significado': 'egal'},
      {'letra': 'I', 'significado': 'nteligente'},
      {'letra': 'V', 'significado': 'alente'},
      {'letra': 'I', 'significado': 'ncrível'},
      {'letra': 'A', 'significado': 'miga'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu nome'),
        backgroundColor: Colors.pink[300], // Cor vibrante na AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink[200]!,
              Colors.pink[100]!,
            ], // Gradiente vibrante de fundo
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children:
              acrostico.map((entry) {
                return Card(
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      '${entry['letra']}  ${entry['significado']}', // Sem hífen
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
