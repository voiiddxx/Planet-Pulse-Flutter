import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:planetpulse/View/Screens/tasks/task.dart';
import 'package:planetpulse/View/Screens/userhome/userhome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    UserHomeScreen(),
    TaskScreen(),
    TaskScreen(),
    TaskScreen(),
    TaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: GNav(
        textSize: 10,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
        activeColor: const Color.fromARGB(255, 39, 39, 39),
        curve: Curves.easeInCirc,
        hoverColor: const Color.fromARGB(149, 54, 54, 54),
        textStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(255, 79, 79, 79),
            fontSize: 12,
            letterSpacing: 0.2),
        gap: 2,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "",
          ),
          GButton(
            icon: Icons.verified,
            text: "Pro Planet Verification",
          ),
          GButton(
            icon: Icons.task_alt_sharp,
            text: "Weekly Tasks",
          ),
          GButton(
            icon: Icons.leaderboard_rounded,
            text: "Leaderboard",
          ),
          GButton(
            icon: Icons.person,
            text: "Profile",
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}
