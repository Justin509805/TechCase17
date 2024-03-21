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
        title: Text('Morse Code Translator'),
      ),
      backgroundColor: Colors.blue, // Set background color of the Scaffold
      body: Center(
        child: Container(
          margin: EdgeInsets.all(50), // Add margin
          constraints: BoxConstraints(maxWidth: 300), // Limit width
          decoration: BoxDecoration(
            color: Colors.white, // Change background color to white
            borderRadius: BorderRadius.circular(16), // Add border radius for a nicer look
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                readOnly: true,
                controller: TextEditingController(text: morseCode),
                decoration: InputDecoration(
                  hintText: 'Enter Morse code',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        translateInputToMorseCode('.');
                      },
                      child: Text(
                        '.', 
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        translateInputToMorseCode('-');
                      },
                      child: Text(
                        '-', 
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),                  
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        decodeMorseCode();
                      },
                      child: Text('Decode Morse Code'),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        clearMorseCode();
                      },
                      child: Text('Clear Morse Code'),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        clearAll();
                      },
                      child: Text('Clear All'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                'Decoded Text:',
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
