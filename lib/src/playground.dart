import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Playground extends StatefulWidget {
  final String title;
  final List<Toy> toys;

  const Playground({@required this.title, @required this.toys});

  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  bool _searchActive = false;

  TextEditingController _textController = TextEditingController();

  get _searchString => _textController.text;

  @override
  Widget build(BuildContext context) {
    List<Toy> toys = widget.toys;
    List<Toy> stringFiltered;
    if (_searchString != '') {
      stringFiltered = toys
          .where((toy) =>
      toy is ToyBox
          ? _containsSearch(toy.issue) ||
          _containsSearch(toy.title) ||
          toy.toys.any((toy) => _containsSearch(toy.title))
          : _containsSearch(toy.title))
          .toList();
    } else {
      stringFiltered = toys;
    }

    return Scaffold(
      appBar: AppBar(
        title: _searchActive
            ? Container(
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: _textController,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              )
            : Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(_searchActive ? Icons.close : Icons.search),
            onPressed: () => setState(() {
              _searchActive = !_searchActive;
              if (!_searchActive) {
                _textController.text = '';
              }
            }),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: stringFiltered.length,
          itemBuilder: (context, index) {
            var toy = stringFiltered[index];
            if (_searchActive) {
              if (toy is ToyBox) {
                return (!_containsSearch(toy.title) &&
                    !_containsSearch(toy.issue))
                    ? toy.expand ? toy : toy.copyWith(expand: true)
                    : toy;
              } else {
                return toy;
              }
            } else {
              return toy;
            }
          }),
    );
  }

  bool _containsSearch(String string) =>
      string.toLowerCase().contains(_textController.text.toLowerCase());
}

class ToyBox extends Toy {
  final List<Toy> toys;
  final String authorEmail;

  final bool expand;

  String get md5sha => md5.convert(utf8.encode(authorEmail)).toString();
  String get gravatarUrl => 'https://www.gravatar.com/avatar/$md5sha';

  const ToyBox({@required this.toys,
    issue,
    issueUrl,
    this.authorEmail,
    this.expand = false,
    title})
      : super(title: title, issue: issue, issueUrl: issueUrl);

  ToyBox copyWith({
    List<Toy> toys,
    String title,
    String issue,
    String issueUrl,
    String authorEmail,
    bool expand,
  }) {
    return new ToyBox(
      toys: toys ?? this.toys,
      title: title ?? this.title,
      issue: issue ?? this.issue,
      issueUrl: issueUrl ?? this.issueUrl,
      authorEmail: authorEmail ?? this.authorEmail,
      expand: expand ?? this.expand,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: ExpansionTile(
              title: Text(title),
              leading: issueUrl == null
                  ? Text(issue)
                  : GestureDetector(
                onTap: _launchIssueUrl,
                child: Text(
                  issue,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.lightBlue),
                ),
              ),
              trailing: authorEmail == null
                  ? null
                  : CircleAvatar(
                backgroundImage: Image
                    .network(gravatarUrl)
                    .image,
              ),
              children: toys),
        ),
      ],
    );
  }

  void _launchIssueUrl() async {
    if (await canLaunch(issueUrl)) {
      await launch(issueUrl);
    } else {
      print('Could not launch $issueUrl');
    }
  }
}

class Toy extends StatelessWidget {
  final WidgetBuilder childBuilder;
  final String title;
  final bool disableScaffold;
  final bool resizable;
  final String issue;
  final String issueUrl;

  const Toy({this.childBuilder,
    this.title,
      this.disableScaffold = false,
    this.resizable = false,
    this.issue,
    this.issueUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => disableScaffold
              ? buildBody(context)
              : Scaffold(
                  appBar: AppBar(
                    title: Text(title),
                  ),
                  body: buildBody(context),
                ))),
    );
  }

  Widget buildBody(BuildContext context) {
    return resizable
        ? ResizableToy(
            builder: childBuilder,
          )
        : childBuilder(context);
  }
}

class ResizableToy extends StatefulWidget {
  final WidgetBuilder builder;

  @override
  _ResizableToyState createState() => _ResizableToyState();

  const ResizableToy({
    this.builder,
  });
}

class _ResizableToyState extends State<ResizableToy> {
  ValueNotifier<Offset> _currentOffset = ValueNotifier(Offset(1, 1));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: _currentOffset,
      builder: (context, value, _) {
        return LayoutBuilder(
          builder: (context, size) => Stack(
            children: <Widget>[
              Container(
                width: size.maxWidth * value.dx,
                height: size.maxHeight * value.dy,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 5),
                ),
                child: widget.builder(context),
              ),
              Positioned(
                left: size.maxWidth * value.dx,
                top: size.maxHeight * value.dy,
                child: FractionalTranslation(
                    translation: Offset(-1, -1),
                    child: GestureDetector(
                      child: Icon(Icons.photo_size_select_small),
                      onPanUpdate: (pan) {
                        var dx2 = pan.globalPosition.dx / size.maxWidth;
                        var dy2 = pan.globalPosition.dy / size.maxHeight;
                        _currentOffset.value =
                            Offset(dx2 > 1 ? 1 : dx2, dy2 > 1 ? 1 : dy2);
                      },
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _currentOffset.dispose();
  }
}

enum AtomicType { atom, molecule, organism, template, page }
