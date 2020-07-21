import 'dart:collection';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class Entry implements Comparable<Entry> {
  String name;
  int days;

  Entry({this.name, this.days});

  @override
  int compareTo(Entry other) {
    if(this.days == other.days) {
      return this.name.compareTo(other.name);
    }

    if(this.days > other.days) {
      return -1;
    }

    return 1;
  }
}

class _MyAppState extends State<MyApp> {
  Iterable<CallLogEntry> _callLogEntries = [];

  @override
  Widget build(BuildContext context) {
    var mono = TextStyle(fontFamily: 'monospace');
    var children = <Widget>[];

    Map peopleDays = new HashMap<String, Set<String>>();

    _callLogEntries.forEach((entry) {
      if(entry.name == null || entry.name.trim().length == 0) {
        return;
      }

      peopleDays.putIfAbsent(entry.name, () => new LinkedHashSet<String>());
      String day = DateFormat('YYYYMMDD').format(DateTime.fromMillisecondsSinceEpoch(entry.timestamp));
      peopleDays[entry.name].add(day);
    });

    List result = new List<Entry>();

    peopleDays.forEach((name, dates) {
      Entry entry = new Entry(name: name, days: dates.length);
      result.add(entry);
    });

    result.sort();

    result.forEach((entry) {
      children.add(
        Column(
          children: <Widget>[
            Divider(),
            Text('Name: ${entry.name}', style: mono),
            Text('Days: ${entry.days}', style: mono),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      );
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Call log by name and days')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      var result = await CallLog.query();
                      setState(() {
                        _callLogEntries = result;
                      });
                    },
                    child: Text("Get stats"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: children),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
