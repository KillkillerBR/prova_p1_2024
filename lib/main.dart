import 'package:flutter/material.dart';
import 'package:novo_projeto/cadastro.dart';
import 'package:novo_projeto/controle/pessoaController.dart';
import 'package:novo_projeto/listagem.dart';
import 'package:novo_projeto/login.dart';
import 'package:novo_projeto/autenticacao/sharedSessao.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return _App();
  }
}

class _App extends State<App> {
  PessoaController pessoaController = PessoaController();
  final Future<String?> token = SharedSessao.carregarToken();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: const Listagem(),
      initialRoute: '/',

      routes: {
        '/': (context) => _carregaHome(),
        '/login': (context) => Login(),
        '/listagem': (context) => Listagem(pessoaController: pessoaController),
        '/cadastro': (context) => Cadastro(pessoaController: pessoaController),
      },
    );
  }

  Widget _carregaHome() {
    return FutureBuilder<String?>(
      future: token,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // ou uma tela de loading
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar token'));
        } else {
          return snapshot.data == null
              ? Login()
              : Listagem(pessoaController: pessoaController);
        }
      },
    );
  }
}
