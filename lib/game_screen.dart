import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TextEditingController textController = TextEditingController();
  String textQuestion = 'ayam';

  void checkAnswer(String answer) {
    if (textController.text == answer) {
      setState(() {
        textQuestion = "berhasil";
      });
    } else {
      setState(() {
        textQuestion = "gagal";
        textController.clear();
        textQuestion = "ayam";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 234, 228),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Center(
                child: Text(textQuestion),
              )),
          Expanded(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hoverColor: Colors.black,
                    labelText: 'User Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
              ),
              MaterialButton(
                  color: Colors.amber,
                  onPressed: () {
                    setState(() {
                      checkAnswer(textQuestion);
                    });
                  })
            ],
          ))
        ],
      ),
    );
  }
}
