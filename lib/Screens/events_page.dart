import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import './todo_page.dart';
import './home_page.dart';
import './login.dart';
import './logout.dart';


class EventsPage extends StatefulWidget {
  const EventsPage({super.key, required this.title});
  final String title;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  var db = FirebaseFirestore.instance;

  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Holidays');

  CollectionReference _personalEventsRef = FirebaseFirestore.instance.collection('PersonalEvents');

  Future<List> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    final int indexVal = 0;
    //final containedData = _fullData[indexVal].toList();
    return allData;
  }

    Future<List> getPersonalData() async {
    QuerySnapshot querySnapshot = await _personalEventsRef.get();
    final allEventData = querySnapshot.docs.map((doc) => doc.data()).toList();

    final int indexVal = 0;
    //final containedData = _fullData[indexVal].toList();
    return allEventData;
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
            title: Text(widget.title),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                  child: const Text('Log Out'),
                  onPressed: () {
                    Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => LogoutPage(title:'See you next time!')),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFFDDD9C)),
                    foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),                   
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                  child: const Text('Change Account'),
                  onPressed: () {
                    Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => LoginPage(title:'Welcome to PersonalPlanner!')),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFFDDD9C)),
                    foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),                   
                  ),
                ),
              ),              
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF0383C4),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Upcoming Personal Events",
                              style: TextStyle(
                                color: Color(0xFF00AAFF),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder<List>(
                              future: getPersonalData(),
                              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                              if (!snapshot.hasData) {
                                // while data is loading:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                // data loaded:
                                final outputEventValue = snapshot.data;
                                return Center(
                                  child: Text(
                                    '${outputEventValue}',
                                    softWrap:true, 
                                  ),
                                );
                              }
                              },
                            ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF0383C4),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,                  
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "2024 United States Holidays",
                              style: TextStyle(
                                color: Color(0xFF00AAFF),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder<List>(
                          future: getData(),
                          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                          if (!snapshot.hasData) {
                            // while data is loading:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            // data loaded:
                            final outputValue = snapshot.data;
                            return Center(
                              child: Text(
                                '${outputValue}',
                                softWrap:true, 
                              ),
                            );
                          }
                          },
                        ),
                      ],
                    ),   
                  ), 
                ),           
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(12),
            height: 75.0,
            color: Color(0xFFC8F6FB),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed:() {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => MyCalendarPage(title:'Personal Calendar')),
                        );
                      }, 
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ]  
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed:() {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => ToDoPage(title:'Todo List')),
                        );
                      }, 
                      icon: const Icon(Icons.checklist),
                      ),
                    ] 
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed:() {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => EventsPage(title:'Events and Holidays')),
                        );
                      }, 
                      icon: const Icon(Icons.celebration),
                    ),
                  ] 
                ),
              ],
            ),
          ),
        ),
    );
  }
}