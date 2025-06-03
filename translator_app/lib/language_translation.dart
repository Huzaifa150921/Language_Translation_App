import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({super.key});

  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {
  final Map<String, String> languageCodes = {
    'English': 'en',
    'Urdu': 'ur',
    'French': 'fr',
  };

  final List<String> languages = ['Urdu', 'English', 'French'];

  String? originLanguage;
  String? destinationLanguage;
  String output = '';
  TextEditingController languageController = TextEditingController();

  void translate(String srcLang, String dstLang, String input) async {
    final translator = GoogleTranslator();

    try {
      var translation = await translator.translate(
        input,
        from: languageCodes[srcLang]!,
        to: languageCodes[dstLang]!,
      );

      setState(() {
        output = translation.text;
      });
    } catch (e) {
      setState(() {
        output = 'Translation failed: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF102233),
      appBar: AppBar(
        title: const Text("Language Translator"),
        centerTitle: true,
        backgroundColor: const Color(0xFF102233),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: originLanguage,
                    hint: const Text(
                      'From',
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    style: const TextStyle(color: Colors.black),
                    items: languages.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang,
                        child: Text(
                          lang,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        originLanguage = value;
                      });
                    },
                  ),
                  const SizedBox(width: 40),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(width: 40),
                  DropdownButton<String>(
                    value: destinationLanguage,
                    hint: const Text(
                      'To',
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    style: const TextStyle(color: Colors.black),
                    items: languages.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang,
                        child: Text(
                          lang,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        destinationLanguage = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: languageController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Enter your text...",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (originLanguage != null &&
                      destinationLanguage != null &&
                      languageController.text.isNotEmpty) {
                    translate(
                      originLanguage!,
                      destinationLanguage!,
                      languageController.text.trim(),
                    );
                  } else {
                    setState(() {
                      output = "Please select both languages and enter text.";
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Translate",
                  style: TextStyle(
                    color: Color(0xFF102233),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                output,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
