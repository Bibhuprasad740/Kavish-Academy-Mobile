import 'package:flutter/material.dart';
import 'package:kavish_academy/constants/colors.dart';
import 'package:kavish_academy/views/screens/home_screen.dart';
import 'package:kavish_academy/views/screens/profile_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
  ];
  int selectedIndex = 0;
  double bottomBarWidth = 30;
  double bottomBarBorderWidth = 3;

  void updatePage(int page) {
    setState(() {
      selectedIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        currentIndex: selectedIndex,
        selectedItemColor: GlobalColors.selectedNavBarColor,
        unselectedItemColor: GlobalColors.accent3,
        // backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedIndex == 0
                        ? GlobalColors.selectedNavBarColor
                        : Theme.of(context).canvasColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedIndex == 1
                        ? GlobalColors.selectedNavBarColor
                        : Theme.of(context).canvasColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}