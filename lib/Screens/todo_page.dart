import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_options.dart';
import 'dart:collection';
import './home_page.dart';
import './events_page.dart';
import './login.dart';
import './logout.dart';

class Event {
  final String title;
  final String? description;
  final DateTime date;
  final String id;

  Event({
    required this.title,
    this.description,
    required this.date,
    required this.id,
  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      date: data['date'].toDate(),
      title: data['title'],
      description: data['description'],
      id: snapshot.id,
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "title": title,
      "description": description
    };
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: const Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key, required this.title});
  final String title;

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {

  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('events');

  bool checkedBox = true;

  Future<List> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Personal Todos",
                      style: TextStyle(
                        color: Color(0xFF00AAFF),
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {},
                        leading: Checkbox(
                          value: false,
                          onChanged: (checkedBox) {},
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Color(0xFFC8F6FB),
                        title:  Row (
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //ellipsis not actually doing job for some reason...
                            Text('This is my test run.', maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis),
                            Text('Due by: 04/15/2024 at 23:59:00', maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis),
                            Text('Not actual from database, just test', maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis), 
                          ],
                        ),
                        trailing: IconButton(
                            iconSize: 30,
                            icon: const Icon(
                              Icons.edit,
                            ),
                            alignment: Alignment.centerRight,
                            onPressed: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                        onTap: () {},
                        leading: Checkbox(
                          value: false,
                          onChanged: (checkedBox) {},
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Color(0xFFC8F6FB),
                        title:  Row (
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Senior Thesis to Dr. Good'),
                            Text('Due by: 04/19/2024 at 12:00:00'),
                            Text('At least 1 week before defense.')
                          ],
                        ),
                        trailing: IconButton(
                            iconSize: 30,
                            icon: const Icon(
                              Icons.edit,
                            ),
                            alignment: Alignment.centerRight,
                            onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Below is the actual DB data, it just needs a user-friendly form",
                      style: TextStyle(
                        color: Color(0xFF00AAFF),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: FutureBuilder<List>(
                    future: getData(),
                    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData) {
                      // while data is loading:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final outputValue = snapshot.data;
                      return Center(
                        child: Text('${outputValue}'),
                      );
                    }
                  },
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFFE9E03),),
                      foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                    ),
                    child: Text("Create New Todo Item"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(0xFFC8F6FB),
                              scrollable: true,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('New Todo'),
                                ],
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Todo Item',
                                          icon: Icon(Icons.draw),
                                        ),
                                      ),
                                      InputDatePickerFormField(
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2102, 06, 19),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Information',
                                          icon: Icon(Icons.featured_play_list_outlined),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [ 
                                Row (
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: 
                                  <Widget>[
                                    FilledButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFFE9E03),),
                                        foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                                      ),
                                      child: Text("Submit"),
                                      onPressed: () {Navigator.push(
                                        context, 
                                        MaterialPageRoute(builder: (context) => ToDoPage(title:'Todo List')),
                                      );},
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                      );                      
                    },
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