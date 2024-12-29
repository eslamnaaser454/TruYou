import 'package:flutter/material.dart';

import 'package:truyou/cbt/AdditionalProgramsPage.dart';
import 'package:truyou/cbt/ProgramDetailPage.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key, required this.programs, required List diagnoses});

  final List<String> programs;

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}
//a* algorithm
// Initialize state variables for programs
class _ExampleScreenState extends State<ExampleScreen> {
  List<Map<String, String>> mainPrograms = [
    {'title': 'Anxiety Management', 'description': 'Learn new techniques'},
    {'title': 'Depression Support', 'description': 'Find effective support'},
    {'title': 'Stress Reduction', 'description': 'Explore better methods'},
    {'title': 'Social Anxiety', 'description': 'Gain confidence'},
    {'title': 'PTSD', 'description': 'Practice mindfulness'},
    {'title': 'Bipolar Disorder', 'description': 'Change negative thought'},
  ];
  //a* algorithm
  // Additional programs that can be added later
  List<String> additionalPrograms = ['Program 9', 'Program 10'];
  List<Map<String, String>> nonChosenPrograms = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInputDialog();
    });
  }
//a* algorithm
// Function to collect user responses through a series of dialogs
  void _showInputDialog() async {
    double depressionScore = await _getScore("Do you have depression?");
    double anxietyScore = await _getScore("Do you have anxiety?");
    double bipolarScore = await _getScore("Do you have bipolar disorder?");
    double ptsdScore = await _getScore("Do you have PTSD?");
    double socialAnxietyScore = await _getScore("Do you have social anxiety?");

    var result = _aStarAlgorithm(depressionScore, anxietyScore, bipolarScore, ptsdScore, socialAnxietyScore);
    _displayOutput(result);
  }
  //a* algorithm
// Dialog to get user input for each condition

  Future<double> _getScore(String question) async {
    return await showDialog<double>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(question),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(1.0),
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(0.0),
                  child: const Text('No'),
                ),
              ],
            );
          },
        ) ??
        0.0;
  }
//a* algorithm
// A* algorithm implementation for program suggestion
  List<Map<String, String>> _aStarAlgorithm(
      double depressionScore,
      double anxietyScore,
      double bipolarScore,
      double ptsdScore,
      double socialAnxietyScore) {
            // Map each program to its relevance score based on user input

    Map<String, double> scores = {
      'Anxiety Management': anxietyScore,
      'Depression Support': depressionScore,
      'Stress Reduction': (depressionScore + anxietyScore) / 2,
      'Social Anxiety': socialAnxietyScore,
      'PTSD': ptsdScore,
      'Bipolar Disorder': bipolarScore
    };
    // A* algorithm implementation
    // Initialize A* algorithm components
    List<Map<String, String>> openSet = List.from(mainPrograms);
    List<Map<String, String>> closedSet = [];
    Map<String, double> gScore = {
          // Calculate initial scores
      for (var program in mainPrograms) program['title']!: double.infinity
    };
    //a* algorithm
    // Main A* algorithm loop
    Map<String, double> fScore = {
            // Sort by f-score to get most promising program

      for (var program in mainPrograms) program['title']!: double.infinity
    };

    for (var program in mainPrograms) {
      gScore[program['title']!] = 1.0 - scores[program['title']]!;
      fScore[program['title']!] = (gScore[program['title']] ?? 0.0) +
          (1.0 - scores[program['title']]!);
    }

    while (openSet.isNotEmpty) {
      openSet.sort((a, b) => fScore[a['title']]!.compareTo(fScore[b['title']]!));
      var current = openSet.removeAt(0);
      closedSet.add(current);
      // Stop after finding top 2 programs
      // Evaluate neighboring programs

      if (closedSet.length >= 3) break;

      for (var neighbor in mainPrograms) {
        if (closedSet.contains(neighbor)) continue;
        // Calculate tentative g-score

        double tentativeGScore = (gScore[current['title']] ?? 0.0) +
            (1.0 - scores[neighbor['title']]!);
        if (!openSet.contains(neighbor)) {
          openSet.add(neighbor);
        } else if (tentativeGScore >= gScore[neighbor['title']]!) {
          continue;
        }
        // Update scores

        gScore[neighbor['title']!] = tentativeGScore;
        fScore[neighbor['title']!] = gScore[neighbor['title']]! +
            (1.0 - scores[neighbor['title']]!);
      }
    }

    return closedSet;
  }

  void _displayOutput(List<Map<String, String>> result) {
    setState(() {
      mainPrograms = result;
      nonChosenPrograms = mainPrograms.where((program) => !result.contains(program)).toList();
    });
  }

  void _removeProgram(String programTitle) {
    setState(() {
      additionalPrograms.add(programTitle);
      mainPrograms.removeWhere((program) => program['title'] == programTitle);
    });
  }

  void _addProgram(String programTitle) {
    setState(() {
      if (!mainPrograms.any((program) => program['title'] == programTitle)) {
        mainPrograms.add(
            {'title': programTitle, 'description': 'Description Of Program'});
        additionalPrograms.remove(programTitle);
      }
    });
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
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 16.0, right: 16.0),
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
                              child: const Icon(Icons.arrow_back,
                                  color: Color(0xFFA259FF)),
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
                            child: const Icon(Icons.wysiwyg_rounded,
                                color: Color(0xFFA259FF)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'Media/images/brain.png',
                          width: 400,
                          height: 400,
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
                          builder: (context) => ProgramDetailPage(
                              programName: program['title']!),
                        ),
                      );
                    },
                    onDelete: () => _removeProgram(program['title']!),
                    label: 'Suggested',
                  )),
              const SizedBox(height: 10),
              Container(
                width: containerWidth,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFA259FF).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    'Non-Chosen Programs',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFA259FF),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...nonChosenPrograms.map((program) => ProgramCard(
                    width: containerWidth,
                    title: program['title']!,
                    description: program['description']!,
                    showAddButton: false,
                    onAdd: () {},
                    onEnter: () {},
                    onDelete: () {},
                  )),
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
  final String label;

  const ProgramCard({
    super.key,
    required this.width,
    this.title = 'Program 6',
    this.description = 'Description Of Program',
    required this.showAddButton,
    required this.onAdd,
    required this.onEnter,
    required this.onDelete,
    this.label = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 140,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                if (label.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.moving_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
              ],
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
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
                        const SizedBox(width: 8),
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