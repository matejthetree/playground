import 'package:flutter/material.dart';
import 'package:wamf_playground/src/playground/playground_view.dart';
import 'package:wamf_playground/wamf_playground.dart';

class AtomicPlaygroundView extends StatefulWidget {
  final List<PlaygroundEntry> entries;

  AtomicPlaygroundView({@required this.entries});

  @override
  _AtomicPlaygroundViewState createState() => _AtomicPlaygroundViewState();
}

class _AtomicPlaygroundViewState extends State<AtomicPlaygroundView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PlaygroundView(
            widgetList:
                AtomicPlaygroundDatasource(widget.entries).getIssueList()));
  }
}

abstract class PlaygroundEntry {
  List<AtomicPlaygroundComponent> get components;

  String get title => this.runtimeType.toString().replaceAll('_', '-');
}
