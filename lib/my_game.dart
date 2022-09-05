import 'package:flutter/material.dart';

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  List grid = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  int jogadas = 0;
  bool startGame = true;
  String jogadorAtual = 'X';
  String informsText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AbsorbPointer(
            absorbing: !startGame,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: const [
                          Text(
                            "H45H",
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Jogo da Velha',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myButton(row: 0, column: 0),
                    myButton(row: 0, column: 1),
                    myButton(row: 0, column: 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myButton(row: 1, column: 0),
                    myButton(row: 1, column: 1),
                    myButton(row: 1, column: 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myButton(row: 2, column: 0),
                    myButton(row: 2, column: 1),
                    myButton(row: 2, column: 2),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(13),
                child: Text(
                  informsText,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AbsorbPointer(
                absorbing: startGame,
                child: Opacity(
                  opacity: startGame ? 0 : 1,
                  child: btStart(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myButton({required int row, required int column}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AbsorbPointer(
        absorbing: grid[row][column] == '' ? false : true,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              click(row: row, column: column);
            });
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 100),
            primary: Colors.blueAccent.shade200,
          ),
          child: Text(
            grid[row][column],
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget btStart() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            startGame = true;
            jogadas = 0;
            grid = List.generate(3, (i) => List.filled(3, ""));
            informsText = '$jogadorAtual é a sua vez';
          });
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(200, 50),
          primary: Colors.grey.shade400,
        ),
        child: Text(
          jogadas > 0 ? "Jogar Novamente" : "Vamos Jogar",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  void click({required int row, required int column}) {
    jogadas++;
    grid[row][column] = jogadorAtual;
    bool existeVencedor =
        verificaVencedor(jogador: jogadorAtual, row: row, column: column);

    if (existeVencedor) {
      informsText = "$jogadorAtual Venceu!";
      startGame = false;
    } else if (existeVencedor == false && jogadas == 9) {
      informsText = "Empate!";
      startGame = false;
    } else {
      if (jogadorAtual == 'X') {
        jogadorAtual = '0';
      } else {
        jogadorAtual = 'X';
      }
      informsText = "$jogadorAtual é a sua vez";
    }
  }

  bool verificaVencedor(
      {required String jogador, required int row, required int column}) {
    bool venceu = true;
    //verifica linha
    for (int i = 0; i < 3; i++) {
      if (grid[row][i] != jogador) {
        venceu = false;
        break;
      }
    }
    //verifica coluna
    if (venceu == false) {
      for (int j = 0; j < 3; j++) {
        if (grid[j][column] != jogador) {
          venceu = false;
          break;
        } else {
          venceu = true;
        }
      }
    }
    //verifica diagonal
    if (venceu == false) {
      if (grid[1][1] == jogador) {
        if (grid[0][0] == jogador && grid[2][2] == jogador) {
          venceu = true;
        } else if (grid[0][2] == jogador && grid[2][0] == jogador) {
          venceu = true;
        }
      }
    }
    return venceu;
  }
}
