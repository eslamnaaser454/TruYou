// بسم الله
// بسم الله
import 'package:flutter/material.dart';
import 'TaskTypeAPage.dart'; // Import TaskTypeAPage
import 'TaskTypeBPage.dart'; // Import TaskTypeBPage
import 'TaskDetailPage.dart';

class ProgramDetailPage extends StatefulWidget {
  final String programName;

  const ProgramDetailPage({Key? key, required this.programName}) : super(key: key);

  @override
  _ProgramDetailPageState createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  late List<Map<String, String>> tasks;

  @override
  void initState() {
    super.initState();
    if (widget.programName == 'Anxiety Management') {
      tasks = [
        {
          'title': 'Deep Breathing',
          'description': 'Breathe deeply and slowly.'
        },
        {
          'title': 'Progressive Muscle Relaxation',
          'description': 'Relax each muscle group.'
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
          'title': 'Grounding Techniques',
          'description': 'Stay present in the moment.'
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
  }

  void openTaskPage(BuildContext context, String taskName, int taskIndex) {
    if (widget.programName == 'Anxiety Management') {
      if (taskName == 'Deep Breathing') {
        // Open TaskDetailPage for the first task
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailPage(
              taskName: taskName,
              videoUrl: '', // No video URL needed
            ),
          ),
        );
      } else if (taskName == 'Progressive Muscle Relaxation') {
        // Open TaskTypeBPage for the third task with specific content
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskTypeBPage(
              taskName: taskName,
              questionText: 'The Five Senses Exercise is a simple and effective grounding technique to help people stay present in the moment, especially during times of distress or anxiety. It works by focusing on your surroundings and engaging your five senses. Here\'s how it works:\n\n'
                            'Notice 5 Things You Can See:\n'
                            'Look around and identify five things you can see. Try to pick something you might not usually notice, like a pattern on the wall, the way light reflects on a surface, or the texture of an object.\n\n'
                            'Notice 4 Things You Can Feel:\n'
                            'Focus on four things you can physically feel, such as the texture of your clothing, the sensation of your feet on the ground, the warmth of your hands, or a breeze against your skin.\n\n'
                            'Notice 3 Things You Can Hear:\n'
                            'Pay attention to the sounds around you. It could be the hum of a fan, birds chirping outside, distant traffic, or even your own breathing.\n\n'
                            'Notice 2 Things You Can Smell:\n'
                            'Notice two distinct smells. If you can’t immediately identify any, look for something nearby to smell, such as a cup of coffee, a piece of fruit, or your own soap or lotion.\n\n'
                            'Notice 1 Thing You Can Taste:\n'
                            'Focus on one thing you can taste. It could be a sip of a drink, a piece of gum, or simply the lingering taste in your mouth.\n\n'
                            'This exercise helps shift attention away from overwhelming thoughts or feelings by focusing on the physical world, providing a sense of grounding and calm.',
              imageAsset: 'images/brain.png', // Replace with your image path
            ),
          ),
        );
      } else if (taskName == 'Thought Record Worksheet') {
        
        // Open TaskTypeAPage for the second task
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskTypeAPage(
              taskName: taskName,
              questionText: 'Question 2',
              imageAsset: 'images/brain.png', // Replace with your image path
            ),
          ),
        );
      }
    } else {
      // Default behavior for other tasks
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDetailPage(
            taskName: taskName,
            videoUrl: '', // No video URL needed
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
                ...List.generate(3, (index) => _buildOptionCard(context, taskIndex, 'Read small book', 'For 10 minutes')),
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

  Widget _buildOptionCard(BuildContext context, int taskIndex, String title, String subtitle) {
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
                tasks[taskIndex]['title'] = title; // Replace task
              });
              Navigator.of(context).pop(); // Close dialog
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
