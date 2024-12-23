import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:truyou/cbt//ProgramDetailPage.dart';
import 'package:truyou/cbt//AdditionalProgramsPage.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key, required this.programs});

  final List<String> programs;

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  List<Map<String, String>> mainPrograms = [
    {
      'title': 'Anxiety Management',
      'description': 'Learn new techniques'
    },
    {
      'title': 'Depression Support',
      'description': 'Find effective support'
    },
    {
      'title': 'Stress Reduction',
      'description': 'Explore better methods'
    },
    {
      'title': 'Social Anxiety',
      'description': 'Gain confidence'
    },
    {
      'title': 'Mindfulness',
      'description': 'Practice mindfulness'
    },
    {
      'title': 'Cognitive Restructuring',
      'description': 'Change negative thought'
    },
    {
      'title': 'Behavioral Activation',
      'description': 'Boost mood & motivation.'
    }
  ];
  List<String> additionalPrograms = ['Program 9', 'Program 10'];

  @override
  void initState() {
    super.initState();
    _loadSavedPrograms();
  }

  Future<void> _loadSavedPrograms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedPrograms = prefs.getStringList('savedPrograms');
    if (savedPrograms != null) {
      setState(() {
        for (var program in savedPrograms) {
          if (!mainPrograms.any((p) => p['title'] == program)) {
            mainPrograms.add({'title': program, 'description': 'Description Of Program'});
          }
        }
      });
    }
  }

  Future<void> _addProgram(String program) async {
    setState(() {
      if (!mainPrograms.any((p) => p['title'] == program)) {
        mainPrograms.add({'title': program, 'description': 'Description Of Program'});
        additionalPrograms.remove(program);
        _showToast(context, program);
      }
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedPrograms = mainPrograms.map((p) => p['title']!).toList();
    await prefs.setStringList('savedPrograms', savedPrograms);
  }

  void _removeProgram(String program) {
    setState(() {
      additionalPrograms.add(program);
      mainPrograms.removeWhere((p) => p['title'] == program);
    });
  }

  void _showToast(BuildContext context, String programTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$programTitle: added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                width: containerWidth,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFFA259FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.arrow_back, color: Color(0xFFA259FF)),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              'CBT Programs',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.wysiwyg_rounded, color: Color(0xFFA259FF)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'Media/images/brain copy.png',
                          width: 400, // Increased width
                          height: 400, // Increased height
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...mainPrograms.map((program) => ProgramCard(
                width: containerWidth,
                title: program['title']!,
                description: program['description']!,
                showAddButton: false,
                onAdd: () {},
                onEnter: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgramDetailPage(programName: program['title']!),
                    ),
                  );
                },
                onDelete: () => _removeProgram(program['title']!),
              )),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdditionalProgramsPage(
                additionalPrograms: additionalPrograms,
                onAddProgram: _addProgram,
              ),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(Icons.open_in_new, color: Color(0xFFA259FF)),
      ),
    );
  }
}

class ProgramCard extends StatelessWidget {
  final double width;
  final String title;
  final String description;
  final bool showAddButton;
  final VoidCallback onAdd;
  final VoidCallback onEnter;
  final VoidCallback onDelete;

  const ProgramCard({
    super.key,
    required this.width,
    this.title = 'Program 6',
    this.description = 'Description Of Program',
    required this.showAddButton,
    required this.onAdd,
    required this.onEnter,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 140, // Increased height to prevent overflow
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE7F6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFFA259FF),
              ),
            ),
            const SizedBox(height: 4),
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
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  if (showAddButton)
                    ElevatedButton(
                      onPressed: onAdd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA259FF),
                        minimumSize: const Size(80, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (!showAddButton)
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: onEnter,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA259FF),
                            minimumSize: const Size(100, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          ),
                          child: const Text(
                            'Enter Now',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
