import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selection moyenne mobile',
      home: KeyboardInput(),
    );
  }
}

class KeyboardInput extends StatefulWidget {
  @override
  _KeyboardInputState createState() => _KeyboardInputState();
}

class _KeyboardInputState extends State<KeyboardInput> {
  TextEditingController _textEditingController = TextEditingController();
  String _displayedText = '';
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection moyenne mobile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Entrer valeur moyenne mobile entre 1 et 20',
                errorText: _errorText.isNotEmpty ? _errorText : null,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _validateInput();
              },
              child: Text('Soumettre'),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),


              child: Text(
                // _displayedText est la veleur entiere selectionnée pour la moyenne mobile
                _displayedText,
                style: TextStyle(fontSize: 16.0),
              ),


            ),
          ],
        ),
      ),
    );
  }

  bool _validateInput() {
    String inputText = _textEditingController.text.trim();

    if (inputText.isEmpty) {
      setState(() {
        _errorText = 'Ce champ est requis';
      });
      return false;
    }

    int? parsedValue = int.tryParse(inputText);
    if (parsedValue == null) {
      setState(() {
        _errorText = 'Veuillez entrer une valeur entière';
      });
      return false;
    }

    if (parsedValue < 1 || parsedValue > 20) {
      setState(() {
        _errorText = 'La valeur doit être entre 1 et 20';
      });
      return false;
    }

    setState(() {
      _errorText = '';
      _displayedText = inputText;
    });
    return true;
  }
}
