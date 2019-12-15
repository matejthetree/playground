import 'package:example/src/ui/my_custom_form.dart';
import 'package:flutter/material.dart';
import 'package:wamf_playground/wamf_playground.dart';

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
          body: Playground(title: "This is Playground", toys: [
            ToyBox(
              issue: 'WAMF-1',
              title: 'Flat Button',
              issueUrl: 'www.wearemobilefirst.com',
              authorEmail: 'matej@wearemobilefirst.com',
              toys: [
                Toy(
                  title: 'Button Disabled',
                  childBuilder: (context) =>
                      FlatButton(
                          onPressed: null, child: Text("Flat Button Disabled")),
                ),
                Toy(
                    title: 'Button Enabled',
                    childBuilder: (context) =>
                        FlatButton(
                            onPressed: () {},
                            child: Text("Flat Button Enabled"))),
              ],
            ),
            ToyBox(
              issue: "WAMF-2",
              title: "Form Molecule",
              issueUrl: 'www.wearemobilefirst.com',
              authorEmail: 'matej@wearemobilefirst.com',
              toys: [
                Toy(
                  childBuilder: (context) => MyCustomForm(),
                  title: "Default Style",
                )
              ],
            ),
            ToyBox(
              issue: "WAMF-3",
              title: "Grid View",
              toys: [
                Toy(
                  title: 'black cupertino',
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
                  title: 'black mountain',
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
                  title: 'englishLike',
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
              ],
            ),
            Toy(
              title: 'only Toy',
              childBuilder: (context) =>
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.pink,
                    ),
                  ),
            )
          ]),
        ));
  }
}
