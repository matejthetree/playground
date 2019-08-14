import 'package:flutter/material.dart';
import 'package:wamf_playground/src/playground/playground_view.dart';
import 'package:wamf_playground/wamf_playground.dart';

class AtomicPlaygroundView extends StatelessWidget {
  final List<PlaygroundEntry> entries;

  AtomicPlaygroundView({@required this.entries});

  @override
  Widget build(BuildContext context) {
    var list = AtomicPlaygroundDatasource(entries).getAtomicList();
    return Scaffold(
      appBar: AppBar(),
      body: PlaygroundView(
        widgetList: list,
      ),
    );
  }
}

abstract class PlaygroundEntry {
  List<AtomicPlaygroundComponent> get components;


  String get title => this.runtimeType.toString();
}
