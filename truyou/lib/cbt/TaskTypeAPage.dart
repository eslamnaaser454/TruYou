//بسم الله
import 'package:flutter/material.dart';
import 'package:truyou/cbt/AnxiousThoughtsPage.dart';

class TaskTypeAPage extends StatefulWidget {
  final String taskName;

  const TaskTypeAPage({Key? key, required this.taskName}) : super(key: key);

  @override
  _TaskTypeAPageState createState() => _TaskTypeAPageState();
}

class _TaskTypeAPageState extends State<TaskTypeAPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _storedEntries = [];

  final Map<String, String> taskInstructions = {
    'Task 1': 'Instruction for Task 1.',
    'Task 2': 'Instruction for Task 2.',
  };

  void _storeEntry() {
    final text = _textController.text;
    if (text.isNotEmpty) {
      final now = DateTime.now();
      final formattedDate = '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}';
      setState(() {
        _storedEntries.add({'text': text, 'date': formattedDate});
        _textController.clear();
      });
    }
  }

  void _navigateToAnxiousThoughtsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnxiousThoughtsPage(storedEntries: _storedEntries),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final instructions = taskInstructions[widget.taskName] ?? 'Instructions not available for this task.';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
              Text(
                widget.taskName,
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.data_usage),
                onPressed: _navigateToAnxiousThoughtsPage,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              instructions,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Identify anxious thoughts here ....',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _storeEntry,
              child: const Text('Store'),
            ),
          ],
        ),
      ),
    );
  }
}
