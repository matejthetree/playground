import 'package:flutter/material.dart';
import 'package:wamf_playground/src/playground/playground_view.dart';
import 'package:wamf_playground/wamf_playground.dart';

class AtomicPlaygroundView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlaygroundView(
      widgetList: AtomicPlaygroundDatasource().getList(),
    );
  }
}
