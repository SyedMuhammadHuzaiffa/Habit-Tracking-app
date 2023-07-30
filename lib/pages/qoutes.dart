import 'package:flutter/material.dart';
import 'package:habit_tracker/resources/qoutesfile.dart';

void main() => runApp(const Qoutes());

class Qoutes extends StatelessWidget {
  const Qoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes App',
      home: const MyHomePage(title: 'Quotes App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void _changeQuote(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quote = Quote.quotes[_currentIndex];
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 251, 252, 251),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.black, width: 8),
                ),
                child: Text(
                  'Quotes Categories',
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Fashion',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  _changeQuote(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Sports',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  _changeQuote(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "Inspirational",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onTap: () {
                  _changeQuote(2);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () => _changeQuote((_currentIndex + 1) % Quote.quotes.length),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  quote.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 18),
                Text(
                  quote.author,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.yellow),
                ),
              ],
            ),
          ),
        ));
  }
}
