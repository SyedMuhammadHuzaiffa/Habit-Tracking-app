import 'package:flutter/material.dart';

void main() {
  runApp(GoalTrackerApp());
}

class GoalTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Goal Tracker',
      home: GoalPage(),
    );
  }
}

class Goal {
  String name;
  List<DateTime> completedDays;
  DateTime? lastCompletionTime;

  Goal(this.name) : completedDays = [];

  bool canComplete() {
    if (lastCompletionTime == null) return true;
    return DateTime.now().difference(lastCompletionTime!) >=
        Duration(hours: 24);
  }
}

class GoalPage extends StatefulWidget {
  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  List<Goal> _goals = [];
  Goal? _selectedGoal;

  void _createNewGoal() async {
    String? goalName = await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _nameController = TextEditingController();
        return AlertDialog(
          title: Text('Create New Goal'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Goal Name'),
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

    if (goalName != null && goalName.isNotEmpty) {
      setState(() {
        _goals.add(Goal(goalName));
      });
    }
  }

  Widget _buildGoalsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _goals.length,
      itemBuilder: (context, index) {
        Goal goal = _goals[index];
        bool isCompleted = _selectedGoal == goal;
        return Card(
          child: ExpansionTile(
            title: Text(
              goal.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              ListTile(
                title: Text('Completed Days: ${goal.completedDays.length}'),
                subtitle: Text('Tap the day to mark completion'),
              ),
              if (!isCompleted && goal.canComplete())
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedGoal = goal;
                      goal.lastCompletionTime = DateTime.now();
                    });
                  },
                  child: Text('Completed'),
                ),
              if (isCompleted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: goal.completedDays.length / 30,
                        child: Container(
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: Text(
                            '${(goal.completedDays.length / 30 * 100).toStringAsFixed(1)}%',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedGoal = null;
                        });
                      },
                      child: Text('Reset Completion'),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Your Goals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            _buildGoalsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewGoal,
        child: Icon(Icons.add),
      ),
    );
  }
}
