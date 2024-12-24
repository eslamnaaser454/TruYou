// بسم الله

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TaskTypeAPage.dart';
import 'TaskTypeBPage.dart';
import 'TaskDetailPage.dart';

class ProgramDetailPage extends StatefulWidget {
  final String programName;

  const ProgramDetailPage({Key? key, required this.programName})
      : super(key: key);

  @override
  _ProgramDetailPageState createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  late List<Map<String, String>> tasks;
  late List<bool> taskCompletion;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
     tasks = [];
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList('tasks');
    final savedCompletion =
        prefs.getStringList('taskCompletion')?.map((e) => e == 'true').toList();
    final lastUpdated = prefs.getInt('lastUpdated') ?? 0;

    if (DateTime.now().millisecondsSinceEpoch - lastUpdated >
        12 * 60 * 60 * 1000) {
      _initializeTasks();
    } else if (savedTasks != null && savedCompletion != null) {
      tasks = savedTasks.map((task) {
        final parts = task.split('|');
        return {'title': parts[0], 'description': parts[1]};
      }).toList();
      taskCompletion = savedCompletion;
    } else {
      _initializeTasks();
    }
    _calculateProgress();
    setState(() {});
  }

  void _initializeTasks() {
    if (widget.programName == 'Anxiety Management') {
      tasks = [
        {
          'title': 'Deep Breathing',
          'description': 'Breathe deeply and slowly.'
        },
        {
         'title': 'Grounding Techniques',
          'description': 'Stay present in the moment.'
        },
        {
          'title': 'Thought Record Worksheet',
          'description': 'Identify and challenge thoughts.'
        },
        {
          'title': 'Mindful Walking',
          'description': 'Focus on each step mindfully.'
        },
        {
           'title': 'Progressive Muscle Relaxation',
          'description': 'Relax each muscle group.'
        },
      ];
    } else {
      tasks = [
        {'title': 'Task 1', 'description': 'Description of Task 1'},
        {'title': 'Task 2', 'description': 'Description of Task 2'},
        {'title': 'Task 3', 'description': 'Description of Task 3'},
        {'title': 'Task 4', 'description': 'Description of Task 4'},
        {'title': 'Task 5', 'description': 'Description of Task 5'},
      ];
    }
    taskCompletion = List<bool>.filled(tasks.length, false);
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings =
tasks.map((task) => '${task['title']}|${task['description']}').toList(); // Line 94
    
    final completionStrings = taskCompletion.map((e) => e.toString()).toList();
    await prefs.setStringList('tasks', taskStrings);
    await prefs.setStringList('taskCompletion', completionStrings);
    await prefs.setInt('lastUpdated', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _calculateProgress() async {
    final completedTasks =
        taskCompletion.where((completed) => completed).length;
    progress = (completedTasks / tasks.length) * 100;
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'progress': progress});
  }


  void openTaskPage(BuildContext context, String taskName, int taskIndex) {
    if (!taskCompletion[taskIndex]) {
      setState(() {
        taskCompletion[taskIndex] = true;
        _calculateProgress();
        _saveTasks();
      });
    }

    if (widget.programName == 'Anxiety Management') {
      if (taskName == 'Deep Breathing') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailPage(
              taskName: taskName,
              videoUrl: '',
            ),
          ),
        );
      } else if (taskName == 'Progressive Muscle Relaxation') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskTypeBPage(
              taskName: taskName,
              questionText:
                  'Notice 5 Things You Can See: Look around and identify five things you can see. Try to pick something you might not usually notice, like a pattern on the wall, the way light reflects on a surface, or the texture of an object.',
              imageAsset: '',
            ),
          ),
        );
      } else if (taskName == 'Thought Record Worksheet') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskTypeAPage(
              taskName: taskName,
              questionText: 'Question 2',
              imageAsset: 'Media/images/brain.png',
            ),
          ),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDetailPage(
            taskName: taskName,
            videoUrl: '',
          ),
        ),
      );
    }
  }

  void _showEditDialog(BuildContext context, int taskIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Replace ${tasks[taskIndex]['title']} to',
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(
                    3,
                    (index) => _buildOptionCard(context, taskIndex,
                        'Read small book', 'For 10 minutes')),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA259FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size.fromHeight(42),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionCard(
      BuildContext context, int taskIndex, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F0FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFA259FF),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFA259FF),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tasks[taskIndex]['title'] = title;
              });
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA259FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              minimumSize: const Size(80, 35),
            ),
            child: const Text(
              'Replace',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Header(
              title: widget.programName,
              onBackPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ExerciseCard(
                    exerciseNumber: tasks[index]['title']!,
                    description: tasks[index]['description']!,
                    onStart: () {
                      openTaskPage(context, tasks[index]['title']!, index);
                    },
                    onEdit: () {
                      _showEditDialog(context, index);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Progress: ${progress.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const Header({
    super.key,
    required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFC0B1E8).withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFFA259FF)),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String exerciseNumber;
  final String description;
  final VoidCallback onStart;
  final VoidCallback onEdit;

  const ExerciseCard({
    super.key,
    required this.exerciseNumber,
    required this.description,
    required this.onStart,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 319,
      height: 130,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F0FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exerciseNumber,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA259FF),
                  ),
                ),
                GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA259FF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.edit, color: Color(0xFFA259FF)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA259FF),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA259FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(58, 40),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
