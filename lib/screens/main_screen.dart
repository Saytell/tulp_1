import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'flashcards_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HistoryScreen(),
    SearchScreen(),
    FavoritesScreen(),
    FlashcardsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor:
            const Color.fromARGB(255, 15, 184, 176), // цвет активного
        unselectedItemColor:
            const Color.fromARGB(255, 61, 34, 24), // неактивного
        backgroundColor: const Color.fromARGB(161, 209, 223, 19), // фон меню
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'История',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Карточки',
          ),
        ],
      ),
    );
  }
}
