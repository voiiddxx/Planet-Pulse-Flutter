import 'package:flutter/material.dart';

class ApplyforAdminScreen extends StatefulWidget {
  const ApplyforAdminScreen({super.key});

  @override
  State<ApplyforAdminScreen> createState() => _ApplyforAdminScreenState();
}

class _ApplyforAdminScreenState extends State<ApplyforAdminScreen> {
  final TextEditingController addresscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: 400,
        width: 800,
        color: Colors.white,
      ),
    );
  }
}
