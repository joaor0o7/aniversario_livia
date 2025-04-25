import 'package:flutter/material.dart';
import 'package:aniversario_lilivs/helpers/versiculo_helper.dart';
import 'package:flutter/services.dart'; // Para carregar o arquivo de assets
import 'dart:convert';

class CapituloPage extends StatelessWidget {
  final String livro;
  final int capitulo;

  const CapituloPage({super.key, required this.livro, required this.capitulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$livro $capitulo'),
        backgroundColor: Colors.pink[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<String>>(
          future: carregarCapitulo(livro, capitulo),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text('Erro ao carregar o capítulo'));
            }

            final versiculos = snapshot.data!;
            return ListView.builder(
              itemCount: versiculos.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(versiculos[index]));
              },
            );
          },
        ),
      ),
    );
  }

  // Função que carrega todos os versículos do capítulo real
  Future<List<String>> carregarCapitulo(String livro, int capitulo) async {
    try {
      // Carregar o arquivo JSON (ou dados do banco) com os versículos
      final String response = await rootBundle.loadString(
        'assets/biblia/pt_acf.json', // Substitua pela localização do seu arquivo
      );
      final List<dynamic> data = json.decode(response);

      // Encontrar o livro e o capítulo
      for (var livroData in data) {
        if (livroData['abbrev'] == livro) {
          final chapters = livroData['chapters'];
          if (capitulo <= chapters.length) {
            final versiculos =
                chapters[capitulo -
                    1]; // Capítulos começam em 1, então ajustamos
            return List<String>.from(
              versiculos,
            ); // Retorna todos os versículos do capítulo
          }
        }
      }
    } catch (e) {
      print('Erro ao carregar o capítulo: $e');
    }

    return []; // Retorna uma lista vazia caso haja algum erro
  }
}
