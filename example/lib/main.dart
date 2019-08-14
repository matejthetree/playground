import 'package:flutter/material.dart';
import 'package:wamf_playground/wamf_playground.dart';
import 'src/entries/flat_button_entry.dart';
import 'src/entries/simple_form_entry.dart';
import 'src/entries/grid_view_entry.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: AtomicPlaygroundView(
          entries: [
            FlatButtonEntry(),
            ..._moleculeEntries(),

          ],
        ),
      ),
    );
  }

  List<PlaygroundEntry> _moleculeEntries() {
    return [
      SimpleFormEntry(),
      GridViewEntry()
    ];
  }
}


