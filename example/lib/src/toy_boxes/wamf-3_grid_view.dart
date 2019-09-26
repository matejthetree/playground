import 'package:flutter/material.dart';
import 'package:wamf_playground/wamf_playground.dart';

class GridViewToyBox extends ToyBox {
  GridViewToyBox()
      : super(
            atomicType: AtomicType.molecule,
            issue: "WAMF-3",
            title: "Grid View",
            toys: [
              Toy(
                variation: 'black cupertino',
                childBuilder: (context) =>
                    GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 items.
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
                ),
              ),
              Toy(
                variation: 'black mountain',
                childBuilder: (context) =>
                    GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 items.
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
                ),
              ),
              Toy(
                variation: 'englishLike',
                childBuilder: (context) =>
                    GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 items.
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
                ),
              ),
            ]);
}

/*


 */
