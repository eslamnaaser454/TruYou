import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExploreScreen(),
    );
  }
}

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view, color: Colors.black),
            onPressed: () {},
          ),
        ],
        title: Text(
          'Explore',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  CategoryButton(
                      text: 'Depression', backgroundColor: Colors.white),
                  CategoryButton(
                      text: 'Anxiety', backgroundColor: Colors.yellow),
                  CategoryButton(
                      text: 'Schizophrenia', backgroundColor: Colors.white),
                  CategoryButton(text: 'Phobia', backgroundColor: Colors.blue),
                  CategoryButton(text: 'Fear', backgroundColor: Colors.white),
                  CategoryButton(
                      text: 'Obsession', backgroundColor: Colors.red),
                  CategoryButton(
                      text: 'Sadness', backgroundColor: Colors.white),
                  CategoryButton(text: 'Anger', backgroundColor: Colors.purple),
                  CategoryButton(
                      text: 'Despair', backgroundColor: Colors.white),
                  CategoryButton(
                      text: 'Insomnia', backgroundColor: Colors.green),
                  CategoryButton(
                      text: 'Frustration', backgroundColor: Colors.white),
                  CategoryButton(
                      text: 'Happiness', backgroundColor: Colors.orange),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(height: 32),
              SectionHeader(title: 'Natural Photos'),
              SizedBox(height: 16),
              ImageCard(
                  imagePath: 'Media/images/explore1.png',
                  title: 'Beautiful Landscape'),
              SizedBox(height: 32),
              SectionHeader(title: 'Articles'),
              SizedBox(height: 16),
              ArticleCard(
                  title: 'The importance of mental health', onRead: () {}),
              SizedBox(height: 8),
              ArticleCard(
                  title: 'How do you improve your mental health?',
                  onRead: () {}),
              SizedBox(height: 8),
              ArticleCard(title: 'Mental health at work', onRead: () {}),
              SizedBox(height: 32),
              SectionHeader(title: 'Videos'),
              SizedBox(height: 16),
              VideoCard(
                  thumbnailUrl: 'http://cp.asset/لقطة-الش.png',
                  title: 'Video Title',
                  duration: '14:00',
                  onPlay: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const CategoryButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// class NavigationBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemSelected;

//   const NavigationBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 96,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: NetworkImage(
//               'https://dashboard.codeparrot.ai/api/assets/Z2a2UREM3nUkN26y'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildNavItem(
//                 0,
//                 'https://dashboard.codeparrot.ai/api/assets/Z2a2UhEM3nUkN26z',
//                 'Home',
//                 29),
//             _buildNavItem(
//                 1,
//                 'https://dashboard.codeparrot.ai/api/assets/Z2a2UhEM3nUkN260',
//                 'CBT',
//                 23),
//             _buildNavItem(
//                 2,
//                 'https://dashboard.codeparrot.ai/api/assets/Z2a2UhEM3nUkN261',
//                 'Explore',
//                 21),
//             _buildNavItem(
//                 3,
//                 'https://dashboard.codeparrot.ai/api/assets/Z2a2UhEM3nUkN262',
//                 'ChatBot',
//                 23),
//             _buildNavItem(
//                 4,
//                 'https://dashboard.codeparrot.ai/api/assets/Z2a2UhEM3nUkN263',
//                 'Profile',
//                 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(
//       int index, String iconPath, String label, double iconSize) {
//     bool isSelected = selectedIndex == index;
//     return GestureDetector(
//       onTap: () => onItemSelected(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: iconSize,
//             height: iconSize,
//             margin: const EdgeInsets.only(bottom: 4),
//             child: Image.network(
//               iconPath,
//               color: isSelected ? Colors.black : Colors.black.withOpacity(0.5),
//             ),
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? Colors.black : Colors.black.withOpacity(0.5),
//               fontSize: 10,
//               fontFamily: 'Inter',
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ArticleCard extends StatelessWidget {
  final String title;
  final VoidCallback onRead;

  const ArticleCard({
    Key? key,
    required this.title,
    required this.onRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 321,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.5),
        border: Border.all(color: Color(0xFF9A4AFF)),
        image: DecorationImage(
          image: NetworkImage(
              'https://dashboard.codeparrot.ai/api/assets/Z2a2UhEM3nUkN264'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 5,
            child: Container(
              width: 69,
              height: 34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://dashboard.codeparrot.ai/api/assets/Z2a2UhEM3nUkN265'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF9A4AFF),
              ),
            ),
          ),
          Positioned(
            right: 11,
            top: 15,
            child: GestureDetector(
              onTap: onRead,
              child: Row(
                children: [
                  Text(
                    'Read',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://dashboard.codeparrot.ai/api/assets/Z2a2UhEM3nUkN266'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const ImageCard({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 314,
      height: 209,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imagePath,
              width: 314,
              height: 209,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'See all',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 14,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF9A4AFF),
            ),
          ),
        ),
      ],
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnailUrl;
  final String title;
  final String duration;
  final VoidCallback onPlay;

  const VideoCard({
    Key? key,
    required this.thumbnailUrl,
    required this.title,
    required this.duration,
    required this.onPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 137,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              thumbnailUrl,
              width: 327,
              height: 137,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Center(
              child: GestureDetector(
                onTap: onPlay,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                duration,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 60,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
