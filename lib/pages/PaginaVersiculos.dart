import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:aniversario_lilivs/helpers/versiculo_helper.dart';
import 'package:aniversario_lilivs/pages/versiculos_page.dart';

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
        future: VersiculoHelper.carregar30Versiculos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Erro ao carregar os versículos'));
          }

          final versiculos = snapshot.data!;
          final box = Hive.box('versiculosBox');

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(versiculos.length, (index) {
                      final dia = index + 1;
                      final chave = 'dia_$dia';

                      final salvo = box.get(chave);

                      final texto =
                          salvo?['texto'] ?? versiculos[index]['texto'];
                      final livro =
                          salvo?['livro'] ?? versiculos[index]['livro'];
                      final capitulo =
                          salvo?['capitulo'] ?? versiculos[index]['capitulo'];
                      final versiculo =
                          salvo?['versiculo'] ?? versiculos[index]['versiculo'];

                      return SizedBox(
                        width: 80,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[100],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            if (salvo == null) {
                              box.put(chave, {
                                'texto': texto,
                                'livro': livro,
                                'capitulo': capitulo,
                                'versiculo': versiculo,
                              });
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => VersiculoPage(
                                      dia: dia,
                                      versiculo:
                                          '$texto\n\n($livro $capitulo:$versiculo)',
                                      livro: livro,
                                      capitulo: capitulo,
                                    ),
                              ),
                            );
                          },
                          child: Text('$dia'),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
