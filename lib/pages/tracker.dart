import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Tracker',
      home: TimeTrackerScreen(),
    );
  }
}

class Tracker {
  String name;
  int hours;
  int minutes;
  int seconds;
  Timer? timer;

  Tracker(
      {required this.name, this.hours = 0, this.minutes = 0, this.seconds = 0});

  void start() {
    if (timer == null || !timer!.isActive) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        seconds++;
        if (seconds >= 60) {
          seconds = 0;
          minutes++;
          if (minutes >= 60) {
            minutes = 0;
            hours++;
          }
          updateUI(); // Update the UI after each second
        }
      });
    }
  }

  void reset() {
    if (timer != null) {
      timer!.cancel();
    }
    hours = 0;
    minutes = 0;
    seconds = 0;
    updateUI(); // Update the UI after resetting the time
  }

  void delete() {
    reset();
  }

  void updateUI() {
    // Call setState to update the UI
  }
}

class TimeTrackerScreen extends StatefulWidget {
  @override
  _TimeTrackerScreenState createState() => _TimeTrackerScreenState();
}

class _TimeTrackerScreenState extends State<TimeTrackerScreen> {
  List<Tracker> _trackers = [];
  String _newTrackerName = '';

  void _createAnotherTracker() async {
    String? trackerName = await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _nameController = TextEditingController();
        return AlertDialog(
          title: Text('Create Tracker'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Tracker Name'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_nameController.text);
              },
              child: Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (trackerName != null && trackerName.isNotEmpty) {
      setState(() {
        _trackers.add(Tracker(name: trackerName));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Your Trackers',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _trackers.length,
              itemBuilder: (context, index) {
                Tracker tracker = _trackers[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Tracker Name: ${tracker.name}'),
                          subtitle: Text(
                              'Time: ${tracker.hours} : ${tracker.minutes} : ${tracker.seconds}'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                tracker
                                    .start(); // Start the timer for this specific tracker
                              },
                              child: Text('Start'),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  tracker.reset();
                                });
                              },
                              child: Text('Reset'),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  tracker.delete();
                                  _trackers.removeAt(index);
                                });
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createAnotherTracker,
        child: Icon(Icons.add),
      ),
    );
  }
}
