import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MorseCodeTranslator {
  static Map<String, String> morseCodeMap = {
    'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.',
    'F': '..-.', 'G': '--.', 'H': '....', 'I': '..', 'J': '.---',
    'K': '-.-', 'L': '.-..', 'M': '--', 'N': '-.', 'O': '---',
    'P': '.--.', 'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-',
    'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-', 'Y': '-.--',
    'Z': '--..', '0': '-----', '1': '.----', '2': '..---', '3': '...--',
    '4': '....-', '5': '.....', '6': '-....', '7': '--...', '8': '---..',
    '9': '----.', ' ': '/'
  };

  static Map<String, String> reverseMorseCodeMap =
      morseCodeMap.map((key, value) => MapEntry(value, key));

  static String textToMorseCode(String text) {
    List<String> result = [];
    for (var char in text.toUpperCase().split('')) {
      if (morseCodeMap.containsKey(char)) {
        result.add(morseCodeMap[char]!);
      }
    }
    return result.join(' ');
  }

  static String morseCodeToText(String morseCode) {
    List<String> morseList = morseCode.split(' ');
    List<String> result = [];
    for (var code in morseList) {
      if (reverseMorseCodeMap.containsKey(code)) {
        result.add(reverseMorseCodeMap[code]!);
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
  bool signalingText = true;

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
            Text(
              signalingText ? 'Input Text:' : 'Morse Code:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  inputText = value;
                  if (signalingText) {
                    morseCode = MorseCodeTranslator.textToMorseCode(inputText);
                  }
                });
              },
              decoration: InputDecoration(
                hintText: signalingText ? 'Enter text' : 'Enter Morse code',
              ),
            ),
            SizedBox(height: 20),
            Text(
              signalingText ? 'Morse Code:' : 'Decoded Text:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              signalingText ? morseCode : MorseCodeTranslator.morseCodeToText(morseCode),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  signalingText = !signalingText;
                  if (signalingText) {
                    morseCode = MorseCodeTranslator.textToMorseCode(inputText);
                  } else {
                    inputText = MorseCodeTranslator.morseCodeToText(morseCode);
                  }
                });
              },
              child: Text(signalingText ? 'Signal Morse Code' : 'Translate to Text'),
            ),
          ],
        ),
      ),
    );
  }
}

