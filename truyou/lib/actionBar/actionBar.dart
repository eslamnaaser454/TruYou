import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  ActionBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Opacity(
            opacity: selectedIndex == 0 ? 1.0 : 0.5,
            child: Image.asset('Media/icons/dashboardd.png',
                width: 24, height: 24),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Opacity(
            opacity: selectedIndex == 1 ? 1.0 : 0.5,
            child: Image.asset('Media/icons/task.png', width: 24, height: 24),
          ),
          label: 'CBT',
        ),
        BottomNavigationBarItem(
          icon: Opacity(
            opacity: selectedIndex == 2 ? 1.0 : 0.5,
            child:
                Image.asset('Media/icons/worldwide.png', width: 24, height: 24),
          ),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Opacity(
            opacity: selectedIndex == 3 ? 1.0 : 0.5,
            child: Image.asset('Media/icons/ai.png', width: 24, height: 24),
          ),
          label: 'ChatBot',
        ),
        BottomNavigationBarItem(
          icon: Opacity(
            opacity: selectedIndex == 4 ? 1.0 : 0.5,
            child: Image.asset('Media/icons/user-1.png', width: 24, height: 24),
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontFamily: 'Urbanist'),
      unselectedLabelStyle: TextStyle(fontFamily: 'Urbanist'),
    );
  }
}
