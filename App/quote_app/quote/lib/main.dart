import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote Generator',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 0, 0, 2), // Set the background color
        hintColor: Color(0xFFF3D7CA), // Set the button background color
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 2), // Set the scaffold background color
        fontFamily: 'Roboto', // Set the default font family
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white), // Set text color for the entire app
          bodyText2: TextStyle(color: Color.fromARGB(255, 250, 153, 7)), // Set text color for the entire app
        ),
      ),
      home: QuoteGenerator(),
    );
  }
}

class QuoteGenerator extends StatefulWidget {
  const QuoteGenerator({Key? key}) : super(key: key);

  @override
  State<QuoteGenerator> createState() => _QuoteGeneratorState();
}

class _QuoteGeneratorState extends State<QuoteGenerator> {
  final String quoteURL = "https://api.adviceslip.com/advice";
  String quote = 'Random Quote';
  List<String> favoriteQuotes = [];

  generateQuote() async {
    var res = await http.get(Uri.parse(quoteURL));
    var result = jsonDecode(res.body);
    print(result["slip"]["advice"]);
    setState(() {
      quote = result["slip"]["advice"];
    });
  }

  addToFavorites() {
    setState(() {
      favoriteQuotes.add(quote);
    });
  }

  viewFavorites() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Favorite Quotes'),
          content: Column(
            children: favoriteQuotes.map((quote) {
              return Text(quote);
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Quote Generator'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: viewFavorites,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              quote,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    generateQuote();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF3D7CA), // Set button background color
                  ),
                  child: Text(
                    'Generate',
                    style: TextStyle(color: Color(0xFF910A67)), // Set button text color
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    addToFavorites();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF3D7CA), // Set button background color
                  ),
                  child: Text(
                    'Add to Favorites',
                    style: TextStyle(color: Color(0xFF910A67)), // Set button text color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
