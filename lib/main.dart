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
  String morseCode = '';
  String decodedText = '';

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
      String newText = MorseCodeTranslator.morseCodeToText(morseCode);
      decodedText += ' $newText'; // Append new text to existing decoded text
    });
  }

  void clearMorseCode() {
    setState(() {
      morseCode = '';
    });
  }

  void clearAll() {
    setState(() {
      decodedText = '';
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Morse Code Translator'),
    ),
    backgroundColor: Colors.blue, // Set background color of the Scaffold
    body: Center(
      child: Container(
        margin: const EdgeInsets.all(50), // Add margin
        constraints: const BoxConstraints(maxWidth: 300), // Limit width
        decoration: BoxDecoration(
          color: Colors.white, // Change background color to white
          borderRadius: BorderRadius.circular(16), // Add border radius for a nicer look
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MORSE', // Title for the text input
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
                        const Text(
              'DECODER', // Title for the buttons
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10), // Add spacing between title and text input
            TextField(
              readOnly: true,
              controller: TextEditingController(text: morseCode),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      translateInputToMorseCode('.');
                    },
                    child: const Text(
                      '.', 
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      translateInputToMorseCode('-');
                    },
                    child: const Text(
                      '-', 
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),// Add spacing between title and buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      decodeMorseCode();
                    },
                    child: const Text('Decode'),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      clearMorseCode();
                    },
                    child: const Text('Clear'),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      clearAll();
                    },
                    child: const Text('Clear All'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Results will appear here',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              decodedText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}
}
