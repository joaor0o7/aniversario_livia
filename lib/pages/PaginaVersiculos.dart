import 'package:flutter/material.dart';
import 'package:aniversario_lilivs/helpers/versiculo_helper.dart';
import 'package:aniversario_lilivs/pages/versiculos_page.dart';
import 'package:aniversario_lilivs/pages/capituloPage.dart';

class PaginaVersiculos extends StatelessWidget {
  const PaginaVersiculos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('30 Dias de Versículos'),
        backgroundColor: Colors.pink[200],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Carregando os versículos
        future: VersiculoHelper.carregar30Versiculos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Erro ao carregar os versículos'));
          }

          final versiculos = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(versiculos.length, (index) {
                final v = versiculos[index];
                final texto = v['texto'];
                final livro = v['livro'];
                final capitulo = v['capitulo'];
                final versiculo = v['versiculo'];

                return SizedBox(
                  width: 80,
                  height: 40,
                  child: Column(
                    children: [
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
                          // Passando corretamente os parâmetros para a VersiculoPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => VersiculoPage(
                                    dia: index + 1,
                                    versiculo:
                                        '$texto\n\n($livro $capitulo:$versiculo)',
                                    livro: livro, // Passando o livro
                                    capitulo: capitulo, // Passando o capítulo
                                  ),
                            ),
                          );
                        },
                        child: Text('${index + 1}'),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
