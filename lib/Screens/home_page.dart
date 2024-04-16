import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_options.dart';
import 'dart:collection';
import 'package:intl/intl.dart';

import './todo_page.dart';
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

//Future<void> deleteEvent(String eventId){
//    return db.collection('events').document(eventId).delete();
//  }



class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({super.key, required this.title});
  final String title;

  //final db = FirebaseFirestore.instance;

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    final snap = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: firstDay)
        .where('date', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: Event.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.date.year, event.date.month, event.date.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
    setState(() {});
  }

  List _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
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
                TableCalendar(
                  eventLoader: _getEventsForTheDay,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  focusedDay: _focusedDay,
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (selectedDay, focusedDay) {
                    print(_events[selectedDay]);
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    weekendTextStyle: TextStyle(
                      color: Color(0xFF00AAFF),
                    ),
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFE9E03),
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle (
                      color: Color(0xFF00AAFF)
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    headerTitleBuilder: (context, day) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(day.toString()),
                      );
                    },
                  ),
                ),
                ..._getEventsForTheDay(_selectedDay).map(
                  (event) => ListTile(
                      title: Text(
                        event.title,
                      ),
                      subtitle: Text(
                        "Deadline: ${event.date.month.toString().padLeft(2,'0')}/${event.date.day.toString().padLeft(2,'0')}/${event.date.year.toString()} at ${event.date.hour.toString().padLeft(2,'0')}:${event.date.minute.toString().padLeft(2,'0')}",
                      ),
                      tileColor: Color(0xFFC8F6FB),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed:() {}, icon: const Icon(Icons.edit)),                      
                          IconButton(onPressed:() {}, icon: const Icon(Icons.delete)),
                        ],
                      ),
                  ),
                ),
                Center (
                  child: FloatingActionButton(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFF00AAFF),
                    hoverColor: Color(0xFFFE9E03),
                    onPressed: null,
                    child: Icon(Icons.add),
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
                        );}, 
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

