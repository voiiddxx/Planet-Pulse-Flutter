import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/Route.dart';
import 'package:planetpulse/View/Screens/start/splash.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 255, 255, 255)),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        onGenerateRoute: (settings) => onGenreateSetting(settings),
      ),
    );
  }
}
