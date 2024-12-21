import 'package:flutter/material.dart';



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
                '50 Total',
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
                  CategoryButton(text: 'Depression', backgroundColor: Colors.white),
                  CategoryButton(text: 'Anxiety', backgroundColor: Colors.yellow),
                  CategoryButton(text: 'Schizophrenia', backgroundColor: Colors.white),
                  CategoryButton(text: 'Phobia', backgroundColor: Colors.blue),
                  CategoryButton(text: 'Fear', backgroundColor: Colors.white),
                  CategoryButton(text: 'Obsession', backgroundColor: Colors.red),
                  CategoryButton(text: 'Sadness', backgroundColor: Colors.white),
                  CategoryButton(text: 'Anger', backgroundColor: Colors.purple),
                  CategoryButton(text: 'Despair', backgroundColor: Colors.white),
                  CategoryButton(text: 'Insomnia', backgroundColor: Colors.green),
                  CategoryButton(text: 'Frustration', backgroundColor: Colors.white),
                  CategoryButton(text: 'Happiness', backgroundColor: Colors.orange),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Selected : Anxiety Phobia Obsession Anger Insomnia Happiness',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (Color(0xFF9A4AFF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text('Search for topics'),
                ),
              ),
              SizedBox(height: 32),
              SectionHeader(title: 'Natural Photos'),
              SizedBox(height: 16),
              ImageCard(imagePath: 'images/image1.png', title: 'Beautiful Landscape'),
              SizedBox(height: 32),
              SectionHeader(title: 'Articles'),
              SizedBox(height: 16),
              ArticleCard(title: 'The importance of mental health', onRead: () {}),
              SizedBox(height: 8),
              ArticleCard(title: 'How do you improve your mental health?', onRead: () {}),
              SizedBox(height: 8),
              ArticleCard(title: 'Mental health at work', onRead: () {}),
              SizedBox(height: 32),
              SectionHeader(title: 'Videos'),
              SizedBox(height: 16),
              ImageCard(imagePath: 'https://dashboard.codeparrot.ai/api/assets/Z2II_5LpdV9y-3O_', title: 'Video Title'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
        onItemSelected: (index) {},
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

class NavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const NavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('https://dashboard.codeparrot.ai/api/assets/Z2IJBJLpdV9y-3PA'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(0, 'https://dashboard.codeparrot.ai/api/assets/Z2IJBZLpdV9y-3PB', 'Home', 29),
            _buildNavItem(1, 'https://dashboard.codeparrot.ai/api/assets/Z2IJBZLpdV9y-3PC', 'CBT', 23),
            _buildNavItem(2, 'https://dashboard.codeparrot.ai/api/assets/Z2IJBpLpdV9y-3PD', 'Explore', 21),
            _buildNavItem(3, 'https://dashboard.codeparrot.ai/api/assets/Z2IJBpLpdV9y-3PE', 'ChatBot', 23),
            _buildNavItem(4, 'https://dashboard.codeparrot.ai/api/assets/Z2IJB5LpdV9y-3PF', 'Profile', 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label, double iconSize) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            margin: const EdgeInsets.only(bottom: 4),
            child: Image.asset(
              iconPath,
              color: isSelected ? Colors.black : Colors.black.withOpacity(0.5),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.black.withOpacity(0.5),
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

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
          image: AssetImage('https://dashboard.codeparrot.ai/api/assets/Z2IJDpLpdV9y-3PG'),
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
                  image: AssetImage('https://dashboard.codeparrot.ai/api/assets/Z2IJE5LpdV9y-3PH'),
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
                        image: AssetImage('https://dashboard.codeparrot.ai/api/assets/Z2IJFJLpdV9y-3PI'),
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
            child: Image.asset(
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
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
