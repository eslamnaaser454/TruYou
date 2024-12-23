
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<List<String>> topics = [
    ['Depression', 'Anxiety', 'Schizophrenia', 'Phobia', 'Fear'],
    ['Obsession', 'Sadness', 'Anger', 'Despair', 'Insomnia'],
    ['Frustration', 'Happiness', 'Headache', 'Stress', 'Worry'],
    ['Calmness', 'Joy', 'Excitement', 'Peace', 'Relaxation'],
  ];

  List<String> selectedTopics = [];
  List<String> imageUrls = [];
  List<Map<String, String>> articles = [];
  final List<String> natureImageMedia = [
    'Media/images/natural_image (1).jpg',
    'Media/images/natural_image (2).jpg',
    'Media/images/natural_image (3).jpg',
    'Media/images/natural_image (4).jpg',
    'Media/images/natural_image (5).jpg',
    'Media/images/natural_image (6).jpg',
    'Media/images/natural_image (7).jpg',
    'Media/images/natural_image (8).jpg',
    'Media/images/natural_image (9).jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            const Text(
              'Explore',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFC0B1E8).withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                icon: const Icon(Icons.widgets_rounded, color: Color(0xFFA259FF)),
                onPressed: () {},
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...topics.map((row) => _buildRow(row)).toList(),
              SizedBox(height: 20),
              Text(
                'Selected: ${selectedTopics.join(', ')}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _searchForTopics,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E6BF2),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Search for topics',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildImageList(),
              const SizedBox(height: 15),
              _buildArticleList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<String> rowTopics) {
    return Container(
      height: 75,
      margin: EdgeInsets.symmetric(vertical: 0.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: rowTopics
            .map((topic) => _ButtonWidget(
                  topic: topic,
                  onSelected: _toggleSelection,
                ))
            .toList(),
      ),
    );
  }

  void _toggleSelection(String topic, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedTopics.add(topic);
      } else {
        selectedTopics.remove(topic);
      }
    });
  }

  Future<void> _searchForTopics() async {
    if (selectedTopics.isEmpty) return;

    final query = selectedTopics.join(' OR ');
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=365a7c877415446e82b362fea76cef98'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        articles = (data['articles'] as List).take(9).map((article) => {
          'title': article['title'] as String,
          'url': article['url'] as String,
        }).toList().cast<Map<String, String>>();
      });
    } else {
      throw Exception('Failed to load articles');
    }

    // Simulate fetching Media images/from the internet
    setState(() {
      imageUrls = List.generate(
          9,
          (index) =>
              'https://via.placeholder.com/150?text=${selectedTopics.isNotEmpty ? selectedTopics[index % selectedTopics.length] : 'Image'}');
    });
  }

  Widget _buildImageList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: natureImageMedia.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            natureImageMedia[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildArticleList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              height: 70, // Decreased height
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF9A4AFF), width: 4),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          12, 8, 8, 8), // Add left padding of 3px
                      child: Text(
                        articles[index]['title']!,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9A4AFF)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () => _launchURL(articles[index]['url']!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9A4AFF),
                        minimumSize: Size(20, double.infinity),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Read',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await url_launcher.canLaunchUrl(uri)) {
    try {
      await url_launcher.launchUrl(
        uri,
        mode: url_launcher.LaunchMode.externalApplication,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to launch URL: $e')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not launch $url')),
    );
  }
}

}

class _ButtonWidget extends StatefulWidget {
  final String topic;
  final Function(String, bool) onSelected;

  _ButtonWidget({required this.topic, required this.onSelected});

  @override
  __ButtonWidgetState createState() => __ButtonWidgetState();
}

class __ButtonWidgetState extends State<_ButtonWidget> {
  Color buttonColor = Colors.white;
  Color textColor = Colors.black;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 100),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (isSelected) {
                buttonColor = Colors.white;
                textColor = Colors.black;
              } else {
                buttonColor = _getRandomColor();
                textColor = Colors.white;
              }
              isSelected = !isSelected;
              widget.onSelected(widget.topic, isSelected);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            shadowColor: Colors.black,
            elevation: 5,
          ),
          child: Text(
            widget.topic,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Color _getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
//بسم الله
// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:url_launcher/url_launcher.dart' as url_launcher;

// class ExplorePage extends StatefulWidget {
//   @override
//   _ExplorePageState createState() => _ExplorePageState();
// }

// class _ExplorePageState extends State<ExplorePage> {
//   final List<List<String>> topics = [
//     ['Depression', 'Anxiety', 'Schizophrenia', 'Phobia', 'Fear'],
//     ['Obsession', 'Sadness', 'Anger', 'Despair', 'Insomnia'],
//     ['Frustration', 'Happiness', 'Headache', 'Stress', 'Worry'],
//     ['Calmness', 'Joy', 'Excitement', 'Peace', 'Relaxation'],
//   ];

//   List<String> selectedTopics = [];
//   List<String> imageUrls = [];
//   List<String> articleUrls = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFFC0B1E8).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Color(0xFFA259FF)),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             ),
//             const Text(
//               'Explore',
//               style: TextStyle(
//                 fontFamily: 'Urbanist',
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFFC0B1E8).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: IconButton(
//                 icon:
//                     const Icon(Icons.widgets_rounded, color: Color(0xFFA259FF)),
//                 onPressed: () {},
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ...topics.map((row) => _buildRow(row)).toList(),
//               SizedBox(height: 20),
//               Text(
//                 'Selected: ${selectedTopics.join(', ')}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _searchForTopics,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF7E6BF2),
//                   minimumSize: const Size(double.infinity, 48),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Search for topics',
//                       style: TextStyle(
//                         fontFamily: 'Urbanist',
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildImageList(),
//               const SizedBox(height: 15),
//               _buildArticleList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRow(List<String> rowTopics) {
//     return Container(
//       height: 75,
//       margin: EdgeInsets.symmetric(vertical: 4.0),
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: rowTopics
//             .map((topic) => _ButtonWidget(
//                   topic: topic,
//                   onSelected: _toggleSelection,
//                 ))
//             .toList(),
//       ),
//     );
//   }

//   void _toggleSelection(String topic, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         selectedTopics.add(topic);
//       } else {
//         selectedTopics.remove(topic);
//       }
//     });
//   }

//   void _searchForTopics() {
//     // Simulate fetching Media images/and articles from the internet
//     setState(() {
//       imageUrls = List.generate(
//           9,
//           (index) =>
//               'https://via.placeholder.com/150?text=${selectedTopics.isNotEmpty ? selectedTopics[index % selectedTopics.length] : 'Image'}');
//       articleUrls = List.generate(
//           3,
//           (index) =>
//               'https://example.com/article?topic=${selectedTopics.isNotEmpty ? selectedTopics[index % selectedTopics.length] : 'Article'}');
//     });
//   }

//   Widget _buildImageList() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//       ),
//       itemCount: imageUrls.length,
//       itemBuilder: (context, index) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(25),
//           child: Image.network(
//             imageUrls[index],
//             fit: BoxFit.cover,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildArticleList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: articleUrls.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(25),
//             child: Container(
//               height: 70, // Decreased height
//               decoration: BoxDecoration(
//                 border: Border.all(color: Color(0xFF9A4AFF), width: 3),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(
//                           12, 8, 8, 8), // Add left padding of 3px
//                       child: Text(
//                         'Article about ${selectedTopics.isNotEmpty ? selectedTopics[index % selectedTopics.length] : 'Topic'}',
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF9A4AFF)),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(5),
//                     child: ElevatedButton(
//                       onPressed: () => _launchURL(articleUrls[index]),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF9A4AFF),
//                         minimumSize: Size(20, double.infinity),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Read',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 255, 255, 255)),
//                           ),
//                           SizedBox(width: 8),
//                           Icon(
//                             Icons.arrow_forward,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _launchURL(String url) async {
//     if (await url_launcher.canLaunch(url)) {
//       await url_launcher.launch(url, forceSafariVC: false, forceWebView: false);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }

// class _ButtonWidget extends StatefulWidget {
//   final String topic;
//   final Function(String, bool) onSelected;

//   _ButtonWidget({required this.topic, required this.onSelected});

//   @override
//   __ButtonWidgetState createState() => __ButtonWidgetState();
// }

// class __ButtonWidgetState extends State<_ButtonWidget> {
//   Color buttonColor = Colors.white;
//   Color textColor = Colors.black;
//   bool isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//       child: ConstrainedBox(
//         constraints: BoxConstraints(minWidth: 100),
//         child: ElevatedButton(
//           onPressed: () {
//             setState(() {
//               if (isSelected) {
//                 buttonColor = Colors.white;
//                 textColor = Colors.black;
//               } else {
//                 buttonColor = _getRandomColor();
//                 textColor = Colors.white;
//               }
//               isSelected = !isSelected;
//               widget.onSelected(widget.topic, isSelected);
//             });
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: buttonColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25.0),
//             ),
//             shadowColor: Colors.black,
//             elevation: 5,
//           ),
//           child: Text(
//             widget.topic,
//             style: TextStyle(
//               color: textColor,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getRandomColor() {
//     final random = Random();
//     return Color.fromARGB(
//       255,
//       random.nextInt(256),
//       random.nextInt(256),
//       random.nextInt(256),
//     );
//   }
// }

/// باستخدام api
//بسم الله