import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import './login.dart';


class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key, required this.title});
  final String title;

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  void _submitForm() { 
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => LoginPage(title:'Welcome to PersonalPlanner!')),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter, 
            colors: [Color(0xFFFDDD9C), Color(0xFFC8F6FB)])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color(0xFFC8F6FB),
            title: Center(child: Text(widget.title),),
          ),
          body: Center(
            child: Column(
              children: [
                Text(
                  "Are you sure you want to log out for now?",
                  style: TextStyle(
                    color: Color(0xFF00AAFF),
                    fontSize: 20,
                  ),
                ),
                FilledButton( 
                  onPressed: _submitForm,
                  child: Text('Log me out!'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF00AAFF)),
                    foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),                   
                  ),
                ), 
              ], 
            ),
          ),
        ),
    );
  }
}