import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popup Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Show the popup
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ConfirmationMessage(
                    title: 'Success!',
                    description: 'Your operation was successful.',
                  ),
                );
              },
            );
          },
          child: const Text('Show Popup'),
        ),
      ),
    );
  }
}

class ConfirmationMessage extends StatelessWidget {
  final String title;
  final String description;

  const ConfirmationMessage({
    Key? key,
    this.title = 'Confirmation Message',
    this.description = 'Description of Message ...........',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 815,
      height: 273,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Container(
        width: 742,
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFEFFAF4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 31),
            Container(
              width: 78,
              height: 78,
           
              child: Center(
                child: Image.asset(
                  'images/check.png',
                  width: 55,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(width: 22),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF000000),
                  ),
                ),
                const SizedBox(height: 13),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Color(0xCC000000),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
