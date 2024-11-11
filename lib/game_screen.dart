import 'dart:math';

import 'package:flutter/material.dart';

Widget _buildStyledCharacter(String char) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.cyan,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      shuffleText(char),
      style: const TextStyle(
          color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
    ),
  );
}

String shuffleText(String input) {
  List<String> chars = input.split('');
  Random random = Random();
  for (int i = chars.length - 1; i > 0; i--) {
    int j = random.nextInt(i + 1);
    String temp = chars[i];
    chars[i] = chars[j];
    chars[j] = temp;
  }

  return chars.join('');
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TextEditingController textController = TextEditingController();
  List<String> textQuestion = <String>[
    'Anjing',
    'Ayam',
    'Babi',
    'Badak',
    'Banteng',
    'Bebek',
    'Beruang',
    'Burung',
    'Buaya',
    'Cicak',
    'Domba',
    'Elang',
    'Gajah',
    'Harimau',
    'Ikan',
    'Jerapah',
    'Kambing',
    'Kanguru',
    'Katak',
    'Kelinci',
    'Kucing',
    'Kuda',
    'Kura-kura',
    'Laba-laba',
    'Landak',
    'Lebah',
    'Lumba-lumba',
    'Macan',
    'Merpati',
    'Musang',
    'Panda',
    'Pinguin',
    'Rajawali',
    'Rusa',
    'Sapi',
    'Serigala',
    'Singa',
    'Tupai',
    'Ular',
    'Zebra',
  ];
  String currentText = '';
  String shuffledText = '';
  int score = 0;

  void checkAnswer(String answer) {
    if (textController.text == answer) {
      setState(() {
        generateTextQuestion();
        score += 100;
        textController.clear();
        if (score >= 100) {
          showDialog(
              context: context,
              builder: (context) => Dialog.fullscreen(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Selamat kamu sangat pintar'),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            score = 0;
                            generateTextQuestion();
                            textController.text = '';
                          },
                          icon: Icon(Icons.repeat))
                    ],
                  )));
        }
      });
    } else {
      setState(() {
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Kamu salah',
                          style: TextStyle(fontSize: 20),
                        ),
                        const Text(
                          "Coba lebih teliti lagi",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 15),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              generateTextQuestion();
                              textController.text = '';
                              score = 0;
                            },
                            icon: Icon(Icons.repeat))
                      ],
                    ),
                  ),
                ));
      });
    }
  }

  void generateTextQuestion() {
    final random = Random();
    String newText;

    do {
      newText = textQuestion[random.nextInt(textQuestion.length)];
    } while (newText == currentText);

    setState(() {
      currentText = newText;
      shuffledText = shuffleText(currentText);
    });
  }

  @override
  void initState() {
    super.initState();
    generateTextQuestion();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 234, 228),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Text(
              'Score: $score',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: shuffledText.length,
                      itemBuilder: (contex, index) {
                        return _buildStyledCharacter(
                            shuffledText[index].toLowerCase());
                      }))),
          Expanded(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hoverColor: Colors.black,
                      labelText: 'Jawaban',
                      hintText: 'Masukan Jawaban',
                      suffixIcon: IconButton(
                        onPressed: () {
                          textController.text.isEmpty
                              ? null
                              : checkAnswer(currentText.toLowerCase());
                        },
                        icon: const Icon(Icons.check),
                      )),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
