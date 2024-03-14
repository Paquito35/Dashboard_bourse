import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard Input',
      home: KeyboardInput(),
    );
  }
}

class KeyboardInput extends StatefulWidget {
  @override
  _KeyboardInputState createState() => _KeyboardInputState();
}

class _KeyboardInputState extends State<KeyboardInput> {
  // Controller pour la zone de texte
  TextEditingController _textEditingController = TextEditingController();

  // Texte à afficher dans la zone de texte en haut à droite
  String _displayedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection moyenne mobile'),
      ),
      body: Stack(
        children: [
          // Partie principale de l'écran
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Zone de texte pour la saisie utilisateur
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Entrer valeur moyenne mobile entre 1 et 20',
                  ),
                ),
                SizedBox(height: 20.0),
                // Bouton pour soumettre la saisie
                ElevatedButton(
                  onPressed: () {
                    _showInputDialog(context);
                  },
                  child: Text('Soumettre'),
                ),
              ],
            ),
          ),
          // Zone de texte en haut à droite
          Positioned(
            top: 20.0,
            right: 20.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              // Affichage du texte saisi
              child: Text(
                _displayedText,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour afficher la boîte de dialogue avec le texte saisi
  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Valeur recue'),
          content: Text('Vous avez sélectionner: ${_textEditingController.text}'),
          actions: <Widget>[
            // Bouton de fermeture de la boîte de dialogue
            TextButton(
              onPressed: () {
                // Mise à jour du texte à afficher en haut à droite
                setState(() {
                  _displayedText = _textEditingController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}
