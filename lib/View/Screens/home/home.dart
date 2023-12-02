import 'package:flutter/material.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final curruser = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      body: Center(
        child: Text(curruser.username),
      ),
    );
  }
}
