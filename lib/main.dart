import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Screens/home_page.dart';
import 'Screens/todo_page.dart';
import 'Screens/events_page.dart';
import 'Screens/login.dart';
import 'Screens/logout.dart';
import 'Screens/createaccount.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
    ),
  );
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/createaccount':(context) => const CreateAccountPage(title: 'Thank you for choosing PersonalPlanner!'), 
      '/login':(context) => const LoginPage(title: 'Welcome to PersonalPlanner!'), 
      '/logout':(context) => const LogoutPage(title: 'See you next time!'),         
      '/calendar':(context) => const MyCalendarPage(title: 'Personal Calendar'),
     '/todo':(context) => const ToDoPage(title: 'Todo List'),
      '/events':(context) => const EventsPage(title: 'Events and Holidays')
    },
 ));
}


