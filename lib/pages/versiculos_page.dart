import 'package:flutter/material.dart';
import 'package:aniversario_lilivs/pages/capituloPage.dart';

class VersiculoPage extends StatelessWidget {
  final int dia;
  final String versiculo;
  final String livro;
  final int capitulo;

  const VersiculoPage({
    super.key,
    required this.dia,
    required this.versiculo,
    required this.livro,
    required this.capitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Versículo do Dia $dia'),
        backgroundColor: Colors.pink[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Exibe o versículo
            Text(versiculo, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[100],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                // Navega para a página do capítulo completo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => CapituloPage(livro: livro, capitulo: capitulo),
                  ),
                );
              },
              child: const Text('Ler mais'),
            ),
          ],
        ),
      ),
    );
  }
}
