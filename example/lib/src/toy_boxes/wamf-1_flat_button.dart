import 'package:flutter/material.dart';
import 'package:wamf_playground/wamf_playground.dart';

class FlatButtonToyBox extends ToyBox {

  FlatButtonToyBox():super(
    atomicType:AtomicType.atom,
    issue:'WAMF-1',
    title:"Flat Button",
    toys:[
      Toy(variation: 'Button Disabled',childBuilder: (context)=> FlatButton(onPressed: null, child: Text("Flat Button Disabled")),),
      Toy(variation: 'Button Enabled',childBuilder:(context)=> FlatButton(onPressed: (){}, child: Text("Flat Button Enabled"))),
    ]

  );
}
