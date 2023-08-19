import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int playerX = 0;
  int playerO = 0;
  int filledCount = 0;
  bool pause = false;
  bool oTurn = true;
  TextStyle textStyle = const TextStyle(fontSize: 30, color: Colors.white);
  List<String> displayXorO = ["", "", "", "", "", "", "", "", ""];

   final myNewFont = const  TextStyle(
    letterSpacing: 3,
    color: Colors.black,
  );

   final myNewFontWhite = const TextStyle(
    fontSize: 18,
    letterSpacing: 3,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player X",
                          style: myNewFont,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "$playerX",
                          style: myNewFontWhite,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player O",
                          style: myNewFont,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "$playerO",
                          style: myNewFontWhite,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: pause ? () {} : () => _tapped(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[700]!),
                        ),
                        child: Center(
                            child: Text(
                          displayXorO[index],
                          style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: Wrap(
                alignment: WrapAlignment.center,
                clipBehavior: Clip.antiAlias,
                runSpacing: 5,
                spacing: 5,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          pause = !pause;
                        });
                      },
                      child: Text(
                        !pause ? "Pause Game" : "Continue",
                        style: myNewFont,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        _clearBoard();
                      },
                      child: Text(
                        "Restart",
                        style: myNewFont,
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Exit",
                        style: myNewFont,
                      )),
                ],
              ))
            ],
          ))
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXorO[index] == "") {
        displayXorO[index] = "o";
        filledCount += 1;
      } else if (!oTurn && displayXorO[index] == "") {
        displayXorO[index] = "x";
        filledCount += 1;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayXorO[0] == displayXorO[1] &&
        displayXorO[0] == displayXorO[2] &&
        displayXorO[0] != "") {
      _showWinnerDialog(displayXorO[0]);
    } else if (displayXorO[3] == displayXorO[4] &&
        displayXorO[3] == displayXorO[5] &&
        displayXorO[3] != "") {
      _showWinnerDialog(displayXorO[3]);
    } else if (displayXorO[0] == displayXorO[4] &&
        displayXorO[0] == displayXorO[8] &&
        displayXorO[0] != "") {
      _showWinnerDialog(displayXorO[0]);
    }
    if (displayXorO[6] == displayXorO[7] &&
        displayXorO[6] == displayXorO[8] &&
        displayXorO[6] != "") {
      _showWinnerDialog(displayXorO[6]);
    } else if (displayXorO[0] == displayXorO[3] &&
        displayXorO[0] == displayXorO[6] &&
        displayXorO[0] != "") {
      _showWinnerDialog(displayXorO[0]);
    } else if (displayXorO[1] == displayXorO[4] &&
        displayXorO[1] == displayXorO[7] &&
        displayXorO[1] != "") {
      _showWinnerDialog(displayXorO[1]);
    } else if (displayXorO[2] == displayXorO[5] &&
        displayXorO[2] == displayXorO[8] &&
        displayXorO[2] != "") {
      _showWinnerDialog(displayXorO[2]);
    } else if (displayXorO[2] == displayXorO[4] &&
        displayXorO[2] == displayXorO[6] &&
        displayXorO[2] != "") {
      _showWinnerDialog(displayXorO[2]);
    } else if (filledCount == 9) {
      _showDrawDialog();
    }
  }

  void _showWinnerDialog(String player) {
    _incrementScore(player);
    _showDialog("Player $player won");
  }

  void _showDrawDialog() {
    _showDialog("It was a draw");
  }

  Future<dynamic> _showDialog(String text) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("play again"),
            )
          ],
        ),
      ),
    );
  }

  void _incrementScore(String player) {
    if (player.toLowerCase() == "o") {
      playerO += 1;
    } else if (player.toLowerCase() == "x") {
      playerX += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      displayXorO = displayXorO.map((e) => "").toList();
      filledCount = 0;
    });
  }
}
