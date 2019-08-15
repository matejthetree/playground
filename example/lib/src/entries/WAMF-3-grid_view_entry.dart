
import 'package:flutter/material.dart';
import 'package:wamf_playground/wamf_playground.dart';

class WAMF_3_GridViewEntry extends PlaygroundEntry {
  @override
  List<AtomicPlaygroundComponent> get components => [
      AtomicPlaygroundComponent(
          type: AtomicType.molecule,
          title: "WAMF-3 Grid View blackMountain ",
          component: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Typography.blackMountainView.headline,
                ),
              );
            }),
          )),
      AtomicPlaygroundComponent(
          type: AtomicType.molecule,
          title: "WAMF-3 Grid View blackCupertino ",
          component: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Typography.blackCupertino.headline,
                ),
              );
            }),
          )),
      AtomicPlaygroundComponent(
          type: AtomicType.molecule,
          title: "WAMF-3 Grid View englishLike2018 ",
          component: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Typography.englishLike2018.headline,
                ),
              );
            }),
          )),
    ];
}



/*


 */