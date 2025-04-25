import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:math';

class VersiculoHelper {
  static List<Map<String, dynamic>>? _versiculosSorteados;

  static Future<List<Map<String, dynamic>>> carregar30Versiculos() async {
    if (_versiculosSorteados != null) {
      return _versiculosSorteados!;
    }

    try {
      final String response = await rootBundle.loadString(
        'assets/biblia/pt_acf.json',
      );
      final List<dynamic> data = json.decode(response);

      List<Map<String, dynamic>> todosVersiculos = [];

      for (var livro in data) {
        final abbrev = livro['abbrev'];
        final chapters = livro['chapters'];

        for (int capIndex = 0; capIndex < chapters.length; capIndex++) {
          final capitulo = chapters[capIndex];

          for (int versIndex = 0; versIndex < capitulo.length; versIndex++) {
            final texto = capitulo[versIndex];

            todosVersiculos.add({
              'livro': abbrev,
              'capitulo': capIndex + 1,
              'versiculo': versIndex + 1,
              'texto': texto,
            });
          }
        }
      }

      todosVersiculos.shuffle(Random());
      _versiculosSorteados = todosVersiculos.take(30).toList();

      print('📖 Versículos aleatórios gerados uma vez');
      return _versiculosSorteados!;
    } catch (e) {
      print('❌ Erro ao carregar o JSON: $e');
      return [];
    }
  }
}
