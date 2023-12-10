import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:planetpulse/View/Screens/Admin/adminhome/adminhome.dart';
import 'package:planetpulse/View/Screens/Admin/tasks/assingtask.dart';
import 'package:planetpulse/View/Screens/rankings/ranking.dart';
import 'package:planetpulse/View/Screens/verify/approveverify.dart';

class AdminBottombar extends StatefulWidget {
  const AdminBottombar({super.key});

  @override
  State<AdminBottombar> createState() => _AdminBottombarState();
}

class _AdminBottombarState extends State<AdminBottombar> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    AdminHomeScreen(),
    ApproveVerificationScreen(),
    AssingTask(),
    AdminHomeScreen(),
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
            text: "Home",
          ),
          GButton(
            icon: Icons.verified,
            text: "Approve Verification",
          ),
          GButton(
            icon: Icons.task_alt_sharp,
            text: "Assign Weekly Tasks",
          ),
          GButton(
            icon: Icons.notification_add_outlined,
            text: "Make an Announcement",
          ),
          GButton(
            icon: Icons.person,
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
