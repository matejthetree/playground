import 'package:flutter/material.dart';
import 'package:wamf_playground/wamf_playground.dart';

class WAMF_1_FlatButtonEntry extends PlaygroundEntry {


  @override
  List<AtomicPlaygroundComponent> get components => [
      AtomicPlaygroundComponent(
          type: AtomicType.atom,
          title: "WAMF-1 Flat Button Disabled",
          component: FlatButton(
            child: Text("Flat Button Disabled"),
          )),
      AtomicPlaygroundComponent(
          type: AtomicType.atom,
          title: "WAMF-1 Flat Button Enabled",
          component: FlatButton(
            child: Text("Flat Button Enabled"),
          )),
    ];

  @override
  String get title => "Overriden title";

}
