import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/tracker.dart';
import 'package:habit_tracker/pages/goal.dart';
import 'package:habit_tracker/pages/qoutes.dart';
import 'package:habit_tracker/pages/home.dart';
import 'splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData.dark(),
      home: Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> tabBar = [
    Home(),
    TimeTrackerApp(),
    GoalTrackerApp(),
    Qoutes(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBar[currentIndex],
      appBar: AppBar(
        title: Center(child: Text("Habit Tracker")),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes_outlined), label: 'Tracker'),
          BottomNavigationBarItem(
              icon: Icon(Icons.punch_clock_outlined), label: 'Goal'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm_outlined), label: 'motivation'),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
