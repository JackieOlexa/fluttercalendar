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
      apiKey: "AIzaSyDMl26TDb3WJrEEA2tFH2Uod2-L9-uH_gI",
      authDomain: "jackies-first-test.firebaseapp.com",
      databaseURL: "https://jackies-first-test-default-rtdb.firebaseio.com",
      projectId: "jackies-first-test",
      storageBucket: "jackies-first-test.appspot.com",
      messagingSenderId: "502972278830",
      appId: "1:502972278830:web:5c950ca5d138a998b2d7bf"
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


