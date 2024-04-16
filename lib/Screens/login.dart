import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import './home_page.dart';
import './createaccount.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _submitForm() { 
    if (_formKey.currentState!.validate()) { 
      _formKey.currentState!.save(); 
    } 
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => MyCalendarPage(title:'Personal Calendar')),
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
                  "Please log in below to access your account!",
                  style: TextStyle(
                    color: Color(0xFF00AAFF),
                    fontSize: 20,
                  ),
                ),
                Form (
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16.0), 
                    child: Column( 
                      children: <Widget>[ 
                        TextFormField( 
                          decoration: InputDecoration(labelText: 'Username'), 
                          validator: (value) { 
                            if (value!.isEmpty) { 
                              return 'Please enter your name.'; 
                            } 
                            return null;
                          }, 
                          onSaved: (value) { 
                            _username = value!;
                          }, 
                        ), 
                        TextFormField( 
                          decoration: InputDecoration(labelText: 'Password'),
                          validator: (value) { 
                            if (value!.isEmpty) { 
                              return 'Please enter your password.';
                            } 
                          }, 
                          onSaved: (value) { 
                            _password = value!;
                          }, 
                        ), 
                        SizedBox(height: 20.0), 
                        FilledButton( 
                          onPressed: _submitForm,
                          child: Text('Log In!'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF00AAFF)),
                            foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),                   
                          ),
                        ), 
                      ], 
                    ),
                  ),
                ),
                FilledButton( 
                          onPressed: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => CreateAccountPage(title:'Thank you for choosing PersonalPlanner!')),
                            );
                          },
                          child: Text('Create Account'),
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