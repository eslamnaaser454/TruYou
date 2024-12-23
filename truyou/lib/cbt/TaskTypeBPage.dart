// بسم الله
import 'package:flutter/material.dart';

class TaskTypeBPage extends StatefulWidget {
  final String taskName;
  final String questionText;
  final String imageAsset;

  TaskTypeBPage({
    required this.taskName,
    required this.questionText,
    required this.imageAsset,
  });

  @override
  _TaskTypeBPageState createState() => _TaskTypeBPageState();
}

class _TaskTypeBPageState extends State<TaskTypeBPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 50),
    )..addListener(() {
        setState(() {});
        if (_animationController.isCompleted) {
          _showCompletionDialog();
        }
      });
    _animationController.forward();
  }

  void _showExitWarningDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit Task'),
        content: Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      ),
    );
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
              Navigator.of(context).pop();
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
      backgroundColor: Colors.white,
      body: SafeArea(
        // Wrap the main content in SafeArea
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
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFFA259FF)),
                      onPressed: () {
                        if (_animationController.isAnimating) {
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
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    _animationController.reset();
                    _animationController.forward();
                  });
                },
                itemCount: 1,
                itemBuilder: (context, index) {
                  return PageContent(
                    pageIndex: index,
                    progress: _animationController.value,
                    questionText: widget.questionText,
                    imageAsset: widget.imageAsset,
                    onNext: () {
                      if (_currentPage < 4) {
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 15.0,
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            backgroundColor: Colors.transparent,
            value: _animationController.value,
          ),
        ),
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
        double imageSize = constraints.maxWidth * 0.5;
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
