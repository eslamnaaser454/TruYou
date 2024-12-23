// بسم الله
import 'package:flutter/material.dart';

class TaskTypeBPage extends StatefulWidget {
  final String taskName; // Add taskName parameter
  final String questionText;
  final String imageAsset;

  TaskTypeBPage({
    required this.taskName, // Initialize taskName
    required this.questionText,
    required this.imageAsset,
  });

  @override
  _TaskTypeBPageState createState() => _TaskTypeBPageState();
}

class _TaskTypeBPageState extends State<TaskTypeBPage> with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30), // 30 seconds per page
    )..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Task Completed'),
        content: Text('You have completed all pages.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ProgramDetailPage()),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.taskName)), // Use taskName as the title
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
            _animationController.reset();
            _animationController.forward();
          });
        },
        itemCount: 5, // Updated to 5 pages
        itemBuilder: (context, index) {
          return PageContent(
            pageIndex: index,
            progress: _animationController.value,
            questionText: widget.questionText,
            imageAsset: widget.imageAsset,
            onNext: () {
              if (_currentPage < 4) { // Updated to handle 5 pages
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else {
                _showCompletionDialog();
              }
            },
          );
        },
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  final int pageIndex;
  final double progress;
  final String questionText;
  final String imageAsset;
  final VoidCallback onNext;

  PageContent({
    required this.pageIndex,
    required this.progress,
    required this.questionText,
    required this.imageAsset,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageSize = constraints.maxWidth * 0.5; // 80% of the width
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  questionText,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onNext,
                child: Text('Next'),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 10, // Height of the progress bar
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Background color without radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5), // Rounded corners for the progress line
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    backgroundColor: Colors.transparent,
                    value: progress, // Smooth progress over 30 seconds
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProgramDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Program Detail Page')),
      body: Center(child: Text('Return to the selected task here.')),
    );
  }
}
