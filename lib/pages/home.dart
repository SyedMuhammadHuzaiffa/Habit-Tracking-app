import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home page',
      home: SimpleScreen(),
    );
  }
}

class SimpleScreen extends StatefulWidget {
  @override
  _SimpleScreenState createState() => _SimpleScreenState();
}

class _SimpleScreenState extends State<SimpleScreen> {
  String _userName = '';

  void _getUserInput() async {
    String? name = await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _nameController = TextEditingController();
        return AlertDialog(
          title: Text('Enter your name'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Your Name'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_nameController.text);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (name != null && name.isNotEmpty) {
      setState(() {
        _userName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.person, size: 44),
                SizedBox(width: 10),
                Text(
                  _userName.isEmpty ? 'Guest' : _userName,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getUserInput,
              child: Text('Enter your name'),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to the Habit Tracker Home Page',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 10),
            Text(
              'This purpose for creating this app was to encourage and help people to develop a healthy life style the developers have come up with best ideas that would help a person acheive such a lifestyle this app contains a tracker page which tracks your different healthy routines a goal page which makes sure you stay on your goal and a motivation qoute page to help keep you going ;)',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
