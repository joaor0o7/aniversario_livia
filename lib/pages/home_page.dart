import 'package:aniversario_lilivs/pages/PaginaVersiculos.dart';
import 'package:flutter/material.dart';
import 'package:aniversario_lilivs/pages/versiculos_page.dart';
import 'package:aniversario_lilivs/pages/nome_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Feliz Aniversário!'),
        backgroundColor: Colors.pink[200],
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Parabéns, Livia! 🎉\n\n felicidades e q Deus continue te abençoando! foi mal n ter conseguido fzr p iphone😢😭. Saiba q eu liko vc a pampa, top 2 pessoa mais maneira q eu conheço kkkkkkk, e desculpa encher seu saco as vezes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NomePage()),
                  );
                },
                child: const Text('Presente 1'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PaginaVersiculos()),
                  );
                },
                child: const Text('Presente 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
