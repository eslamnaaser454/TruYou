// بسم الله
import 'package:flutter/material.dart';
import 'dart:async';

class TaskDetailPage extends StatefulWidget {
  final String taskName;
  final String videoUrl; // Add a video URL parameter

  const TaskDetailPage({Key? key, required this.taskName, required this.videoUrl}) : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  bool isRunning = false;
  double progress = 0.0;
  Timer? timer;
  int remainingSeconds = 120; // 2 minutes


  final Map<String, String> taskInstructions = {
    'Deep Breathing': 'Inhale deeply, hold briefly, exhale slowly, repeat for calm.',
    'Progressive Muscle Relaxation': 'Tense and relax each muscle group slowly.',
    'Thought Record Worksheet': 'Identify and challenge negative thoughts effectively.',
    'Mindful Walking': 'Focus on each step, breathe, and observe surroundings.',
    'Grounding Techniques': 'Use senses to connect with the present moment.',
  };

  void _toggleTimer() {
    if (isRunning) {
      timer?.cancel();
    } else {
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          progress += 1 / 1200; // 1200 steps for smoother progress
          remainingSeconds = 120 - (progress * 120).toInt();
          if (progress >= 1.0) {
            timer.cancel();
            _showCompletionDialog();
          }
        });
      });
    }
    setState(() {
      isRunning = !isRunning;
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Task Completed'),
        content: const Text('You have completed the task.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Return to tasks page
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showExitWarningDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Return to tasks page
            },
            child: const Text('Exit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }

  void _showImportanceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Task Importance'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info, size: 50, color: Color(0xFFA259FF)),
            const SizedBox(height: 10),
            const Text(
              'This task is important because it helps improve your skills and knowledge in the subject.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final instructions = taskInstructions[widget.taskName] ?? 'Instructions not available for this task.';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFC0B1E8).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xFFA259FF)),
                        onPressed: () {
                          if (isRunning) {
                            _showExitWarningDialog();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.taskName,
                      style: const TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      instructions,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[300],
                            color: const Color(0xFFA259FF),
                            strokeWidth: 8,
                          ),
                        ),
                        Text(
                          _formatTime(remainingSeconds),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton.icon(
                      onPressed: _toggleTimer,
                      icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
                      label: Text(isRunning ? 'Pause' : 'Resume'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA259FF),
                        minimumSize: const Size(150, 50),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(25),
                    //   child: Image.network(
                    //     'https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExcW5jZmh0cGRrZnZucDY4Y3RncG5rNDBub2V3bm14OTBybDNreXgyeCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/whVGEJ7ieEU41Hx7q0/giphy.gif',
                    //     width: 300,
                    //     height: 300,
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showImportanceDialog,
        backgroundColor: const Color(0xFFA259FF),
        child: const Icon(Icons.search),
      ),
    );
  }
}
