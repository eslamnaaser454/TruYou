//بسم الله
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AnxiousThoughtsPage extends StatefulWidget {
  final List<Map<String, String>> storedEntries;

  const AnxiousThoughtsPage({Key? key, required this.storedEntries}) : super(key: key);

  @override
  _AnxiousThoughtsPageState createState() => _AnxiousThoughtsPageState();
}

class _AnxiousThoughtsPageState extends State<AnxiousThoughtsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredEntries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString('anxiousThoughts') ?? '[]';
    final List<Map<String, String>> loadedEntries = List<Map<String, String>>.from(json.decode(storedData));
    setState(() {
      _filteredEntries = loadedEntries.isNotEmpty ? loadedEntries : widget.storedEntries;
    });
  }

  Future<void> _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('anxiousThoughts', json.encode(_filteredEntries));
  }

  void _filterEntries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredEntries = widget.storedEntries;
      } else {
        _filteredEntries = widget.storedEntries
            .where((entry) => entry['text']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _editEntry(int index, String newText) {
    setState(() {
      _filteredEntries[index]['text'] = newText;
      _saveEntries();
    });
  }

  void _deleteEntry(int index) {
    setState(() {
      _filteredEntries.removeAt(index);
      _saveEntries();
    });
  }

  void _copyEntry(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // Wrap the entire content in SafeArea
        child: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
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
                      'Anxious Thoughts',
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFC0B1E8).withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search my anxious thoughts...',
                        prefixIcon: const Icon(Icons.search, color: Color(0xFFA259FF)),
                        hintStyle: const TextStyle(color: Color.fromARGB(255, 192, 192, 192), fontSize: 16),
                      ),
                      onChanged: _filterEntries,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filteredEntries.length,
                        itemBuilder: (context, index) {
                          final entry = _filteredEntries[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E8FF),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.work_outline_rounded, color: Color(0xFFA259FF)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    entry['text']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Color(0xFFA259FF)),
                                  onPressed: () async {
                                    final newText = await _showEditDialog(entry['text']!);
                                    if (newText != null) {
                                      _editEntry(index, newText);
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy, color: Color(0xFFA259FF)),
                                  onPressed: () => _copyEntry(entry['text']!),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteEntry(index),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showEditDialog(String currentText) async {
    final TextEditingController editController = TextEditingController(text: currentText);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Entry'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(editController.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
