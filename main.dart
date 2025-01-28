import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart'; // Importando o pacote

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = ""; // Variável para armazenar o input do usuário

  // Função para adicionar números e operadores ao input
  void _adicionarValor(String valor) {
    setState(() {
      input += valor;
    });
  }

  // Função para limpar o input
  void _limpar() {
    setState(() {
      input = "";
    });
  }

  // Função para calcular o resultado
  void _calcularResultado() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(input); // Parse da expressão
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm); // Avaliar o resultado
      setState(() {
        input = result.toString(); // Exibe o resultado
      });
    } catch (e) {
      setState(() {
        input = "Erro!"; // Se houver erro, mostra a mensagem
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Exibe o input atual da calculadora
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              input,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          // Grid com os botões da calculadora
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 botões por linha
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                String botao = '';
                switch (index) {
                  case 0:
                    botao = '7';
                    break;
                  case 1:
                    botao = '8';
                    break;
                  case 2:
                    botao = '9';
                    break;
                  case 3:
                    botao = '/';
                    break;
                  case 4:
                    botao = '4';
                    break;
                  case 5:
                    botao = '5';
                    break;
                  case 6:
                    botao = '6';
                    break;
                  case 7:
                    botao = '*';
                    break;
                  case 8:
                    botao = '1';
                    break;
                  case 9:
                    botao = '2';
                    break;
                  case 10:
                    botao = '3';
                    break;
                  case 11:
                    botao = '-';
                    break;
                  case 12:
                    botao = '0';
                    break;
                  case 13:
                    botao = '.';
                    break;
                  case 14:
                    botao = '=';
                    break;
                  case 15:
                    botao = '+';
                    break;
                }

                return ElevatedButton(
                  onPressed: () {
                    if (botao == "=") {
                      _calcularResultado();
                    } else {
                      _adicionarValor(botao);
                    }
                  },
                  child: Text(
                    botao,
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ),
          // Botão de limpar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _limpar,
              child: Text(
                'Limpar',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
