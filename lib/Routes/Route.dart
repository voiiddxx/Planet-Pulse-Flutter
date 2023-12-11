import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/View/Screens/Admin/adminbottomnavbar.dart';
import 'package:planetpulse/View/Screens/Admin/tasks/approveweekly.dart';
import 'package:planetpulse/View/Screens/Auth/login.dart';
import 'package:planetpulse/View/Screens/Auth/register.dart';
import 'package:planetpulse/View/Screens/comments/commentscreen.dart';
import 'package:planetpulse/View/Screens/home/home.dart';
import 'package:planetpulse/View/Screens/start/splash.dart';
import 'package:planetpulse/View/Screens/verify/approvemain.dart';
import 'package:planetpulse/View/Screens/verify/submitverify.dart';

Route<dynamic> onGenreateSetting(RouteSettings settings) {
  switch (settings.name) {
    case RoutesNames.splashScreen:
      return MaterialPageRoute(builder: (context) {
        return const SplashScreen();
      });
    case RoutesNames.homescreen:
      return MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      });
    case RoutesNames.registerScreen:
      return MaterialPageRoute(builder: (context) {
        return const RegisterScreen();
      });
    case RoutesNames.loginScreen:
      return MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      });
    case RoutesNames.adminbottombar:
      return MaterialPageRoute(builder: (context) {
        return const AdminBottombar();
      });
    case RoutesNames.submitscreen:
      return MaterialPageRoute(builder: (context) {
        var image = settings.arguments as File;
        var submitTask = settings.arguments as String;
        return SubmitSCreen(
          image: image,
          submitTask: submitTask,
        );
      });
    case RoutesNames.approvemainscreen:
      return MaterialPageRoute(builder: (context) {
        // ignore: non_constant_identifier_names
        var ApproveUser = settings.arguments as dynamic;
        return ApprovemainScreen(
          ApproveUser: ApproveUser,
        );
      });
    case RoutesNames.approveweekly:
      return MaterialPageRoute(builder: (context) {
        // ignore: non_constant_identifier_names
        return const ApproveWeeklyTaskScreen();
      });
    case RoutesNames.commentScreen:
      return MaterialPageRoute(builder: (context) {
        var postid = settings.arguments as String;
        // ignore: non_constant_identifier_names
        return CommentScreen(
          postid: postid,
        );
      });

    default:
      return MaterialPageRoute(builder: (context) {
        return const SplashScreen();
      });
  }
}
