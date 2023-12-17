import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:planetpulse/View/Screens/posts/addpost.dart';
import 'package:planetpulse/View/Screens/rankings/ranking.dart';
import 'package:planetpulse/View/Screens/userhome/userhome.dart';
import 'package:planetpulse/View/Screens/weekly/weeklyscreen.dart';
import 'package:planetpulse/View/events/eventsscreen.dart';
import 'package:planetpulse/utils/colors/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    UserHomeScreen(),
    EventsScreen(),
    AddPostScreen(),
    WeeklyScreen(),
    RankingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: GNav(
        textSize: 10,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
        activeColor: GlobalColor.primarycolor,
        curve: Curves.easeInCirc,
        hoverColor: const Color.fromARGB(149, 54, 54, 54),
        textStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w400,
            color: GlobalColor.primarycolor,
            fontSize: 12,
            letterSpacing: 0.2),
        gap: 2,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.event_available_sharp,
            text: "Events",
          ),
          GButton(
            icon: Icons.add_circle_outline_sharp,
            text: "Add Post",
          ),
          GButton(
            icon: Icons.task_outlined,
            text: "Weekly Tasks",
          ),
          GButton(
            icon: Icons.leaderboard_sharp,
            text: "Leaderboard",
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
