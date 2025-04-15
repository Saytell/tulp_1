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
  static const colorSelectedItemMenu = Color.fromARGB(255, 13, 124, 39);
  static const colorUselectedItemMenu = Color.fromARGB(255, 0, 0, 2);
  static const colorBackgroundMenu = Color.fromARGB(255, 168, 168, 170);

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
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: colorSelectedItemMenu,
            unselectedItemColor: colorUselectedItemMenu,
            backgroundColor: colorBackgroundMenu,
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
        ));
  }
}
