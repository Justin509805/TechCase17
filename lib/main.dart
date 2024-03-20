import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MorseCodeTranslator {
  static Map<String, String> morseCodeMap = {
    '.-': 'A', '-...': 'B', '-.-.': 'C', '-..': 'D', '.': 'E',
    '..-.': 'F', '--.': 'G', '....': 'H', '..': 'I', '.---': 'J',
    '-.-': 'K', '.-..': 'L', '--': 'M', '-.': 'N', '---': 'O',
    '.--.': 'P', '--.-': 'Q', '.-.': 'R', '...': 'S', '-': 'T',
    '..-': 'U', '...-': 'V', '.--': 'W', '-..-': 'X', '-.--': 'Y',
    '--..': 'Z', '-----': '0', '.----': '1', '..---': '2', '...--': '3',
    '....-': '4', '.....': '5', '-....': '6', '--...': '7', '---..': '8',
    '----.': '9', '/': ' '
  };

  static String morseCodeToText(String morseCode) {
    List<String> morseList = morseCode.trim().split(' ');
    List<String> result = [];
    for (var code in morseList) {
      if (morseCodeMap.containsKey(code)) {
        result.add(morseCodeMap[code]!);
      }
    }
    return result.join('');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MorseCodeApp(),
    );
  }
}

class MorseCodeApp extends StatefulWidget {
  @override
  _MorseCodeAppState createState() => _MorseCodeAppState();
}

class _MorseCodeAppState extends State<MorseCodeApp> {
  String inputText = '';
  String morseCode = '';

  void translateInputToMorseCode(String signal) {
    setState(() {
      if (signal == '.') {
        morseCode += '.';
      } else if (signal == '-') {
        morseCode += '-';
      }
    });
  }

  void decodeMorseCode() {
    setState(() {
      inputText = MorseCodeTranslator.morseCodeToText(morseCode);
      morseCode = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Morse Code Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  inputText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Morse code',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    translateInputToMorseCode('.');
                  },
                  child: Text('Dot'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    translateInputToMorseCode('-');
                  },
                  child: Text('Dash'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                decodeMorseCode();
              },
              child: Text('Decode Morse Code'),
            ),
            SizedBox(height: 20),
            Text(
              'Decoded Text:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              inputText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
