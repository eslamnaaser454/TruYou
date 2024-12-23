//بسم الله
import 'package:flutter/material.dart';

class AdditionalProgramsPage extends StatelessWidget {
  final List<String> additionalPrograms;
  final Function(String) onAddProgram;

  const AdditionalProgramsPage({
    Key? key,
    required this.additionalPrograms,
    required this.onAddProgram,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: SafeArea( // Wrap the AppBar in SafeArea
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC0B1E8).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFFA259FF)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Additional Programs',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea( // Wrap the main content in SafeArea
        child: Center(
          child: additionalPrograms.isEmpty
              ? const Text(
                  'No additional programs available',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFA259FF),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: additionalPrograms.map((program) => ProgramCard(
                      width: containerWidth,
                      title: program,
                      description: 'Description Of Program',
                      showAddButton: true,
                      onAdd: () {
                        onAddProgram(program);
                        Navigator.of(context).pop();
                      },
                      onEnter: () {},
                      onDelete: () {},
                    )).toList(),
                  ),
                ),
        ),
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
              child: ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA259FF),
                  minimumSize: const Size(50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16,
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
