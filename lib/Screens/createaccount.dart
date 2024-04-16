import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import './login.dart';


class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key, required this.title});
  final String title;

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _email = '';
  String _country = '';
  String _temppass = '';

  void _submitForm() { 
    if (_formKey.currentState!.validate()) { 
      _formKey.currentState!.save(); 
    } 
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
                  "Please fill in the following information to create you account!",
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
                              return 'Please enter your desired username.'; 
                            } 
                            return null;
                          }, 
                          onSaved: (value) { 
                            _username = value!;
                          }, 
                        ),
                        TextFormField( 
                          decoration: InputDecoration(labelText: 'Email'), 
                          validator: (value) { 
                            if (value!.isEmpty) { 
                              return 'Please enter your personal email.'; 
                            } 
                            return null;
                          }, 
                          onSaved: (value) { 
                            _email = value!;
                          }, 
                        ),
                        TextFormField( 
                          decoration: InputDecoration(labelText: 'Password'), 
                          validator: (value) { 
                            if (value!.isEmpty) { 
                              return 'Please enter your desired password.'; 
                            } 
                            return null;
                          }, 
                          onSaved: (value) { 
                            _password = value!;
                          }, 
                        ),
                        TextFormField( 
                          decoration: InputDecoration(labelText: 'Check Password'), 
                          validator: (value) { 
                            if (value!.isEmpty) { 
                              return 'Please reenter your desired password.'; 
                            } 
                            return null;
                          }, 
                          onSaved: (value) { 
                            _temppass = value!;
                          }, 
                        ),
                        TextFormField( 
                          decoration: InputDecoration(labelText: 'Resident Country'), 
                          validator: (value) { 
                            if (value!.isEmpty) { 
                              return 'Please enter your country of residence for tailored holidays.'; 
                            } 
                            return null;
                          }, 
                          onSaved: (value) { 
                            _country = value!;
                          }, 
                        ),
                        SizedBox(height: 20.0), 
                        FilledButton( 
                          onPressed: _submitForm,
                          child: Text('Create Account!'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF00AAFF)),
                            foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),                   
                          ),
                        ), 
                      ], 
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}