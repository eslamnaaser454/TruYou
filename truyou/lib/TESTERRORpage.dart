import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PopupExample(),
  ));
}

class PopupExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popup Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Use the context available here
            showDialog(
              context: context,
              builder: (context) => ErrorMessagePopup(
                title: 'Custom Error',
                description: 'Something went wrong. Please try again.',
              ),
            );
          },
          child: const Text('Show Error Message'),
        ),
      ),
    );
  }
}

class ErrorMessagePopup extends StatelessWidget {
  final String title;
  final String description;

  const ErrorMessagePopup({
    Key? key,
    this.title = 'Error Message',
    this.description = 'Description of the message...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 300, // Adjust popup width
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/atention1.png',
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white.withOpacity(0.8),
                    ),
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
