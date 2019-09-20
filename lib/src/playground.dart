import 'package:flutter/material.dart';

class Playground extends StatefulWidget {
  final String title;
  final List<ToyBox> toyBoxes;

  const Playground({
    @required this.title,
    @required this.toyBoxes,
  });

  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  AtomicFilter _atomicFilter = AtomicFilter.all();
  bool _searchActive = false;

  TextEditingController _textController = TextEditingController();

  get _searchString => _textController.text;

  @override
  Widget build(BuildContext context) {
    List<ToyBox> toyBoxes = widget.toyBoxes;
    List<ToyBox> atomicFiltered = !_atomicFilter.isAll
        ? toyBoxes.where((toyBox) {
            return _atomicFilter.typeActive(toyBox.atomicType);
          }).toList()
        : toyBoxes;
    List<ToyBox> stringFiltered = _searchString != ''
        ? atomicFiltered
            .where((toyBox) =>
                _containsSearch(toyBox.issue) ||
                _containsSearch(toyBox.title) ||
                toyBox.toys.any((toy) => _containsSearch(toy.variation)))
            .toList()
        : atomicFiltered;
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
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => showModalBottomSheet(
                context: context,
                builder: (buildContext) => StatefulBuilder(
                      builder: (context, setModalState) => AtomicFilterModal(
                          atomicFilter: _atomicFilter,
                          onChange: (atomicFilter) {
                            _atomicFilter = atomicFilter;
                            setState(() {});
                            setModalState(() {});
                          }),
                    )),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: stringFiltered.length,
          itemBuilder: (context, index) {
            var toyBox = stringFiltered[index];
            var expanded = _searchActive &&
                !_containsSearch(toyBox.title) &&
                !_containsSearch(toyBox.issue);
            return toyBox.construct(context, expanded, _searchString);
          }),
    );
  }

  bool _containsSearch(String string) =>
      string.toLowerCase().contains(_textController.text.toLowerCase());
}

class AtomicFilter {
  final bool atom;
  final bool molecule;
  final bool organism;
  final bool template;
  final bool page;

  const AtomicFilter({
    @required this.atom,
    @required this.molecule,
    @required this.organism,
    @required this.template,
    @required this.page,
  });

  bool get isAll => atom && molecule && organism && template && page;

  AtomicFilter copyWith({
    bool atom,
    bool molecule,
    bool organism,
    bool template,
    bool page,
  }) {
    return new AtomicFilter(
      atom: atom ?? this.atom,
      molecule: molecule ?? this.molecule,
      organism: organism ?? this.organism,
      template: template ?? this.template,
      page: page ?? this.page,
    );
  }

  AtomicFilter.all()
      : this.atom = true,
        this.molecule = true,
        this.organism = true,
        this.template = true,
        this.page = true;

  bool typeActive(AtomicType atomicType) {
    switch (atomicType) {
      case AtomicType.atom:
        return atom;
      case AtomicType.molecule:
        return molecule;
      case AtomicType.organism:
        return organism;
      case AtomicType.template:
        return template;
      case AtomicType.page:
        return page;
      default:
        return null;
    }
  }
}

typedef void AtomicFilterCallback(AtomicFilter atomicFilter);

class AtomicFilterModal extends StatelessWidget {
  final AtomicFilter atomicFilter;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: <Widget>[
          Text("Atom"),
          Checkbox(
            value: atomicFilter.atom,
            onChanged: (value) => onChange(atomicFilter.copyWith(atom: value)),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Text("Molecule"),
          Checkbox(
            value: atomicFilter.molecule,
            onChanged: (value) =>
                onChange(atomicFilter.copyWith(molecule: value)),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Text("Organism"),
          Checkbox(
            value: atomicFilter.organism,
            onChanged: (value) =>
                onChange(atomicFilter.copyWith(organism: value)),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Text("Template"),
          Checkbox(
            value: atomicFilter.template,
            onChanged: (value) =>
                onChange(atomicFilter.copyWith(template: value)),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Text("Page"),
          Checkbox(
            value: atomicFilter.page,
            onChanged: (value) => onChange(atomicFilter.copyWith(page: value)),
          ),
        ],
      ),
    ]);
  }

  const AtomicFilterModal({
    @required this.atomicFilter,
    @required this.onChange,
  });
}

abstract class ToyBox {
  final List<Toy> toys;
  final String title;
  final String issue;
  final AtomicType atomicType;

  const ToyBox({
    @required this.toys,
    @required this.title,
    @required this.issue,
    @required this.atomicType,
  });

  Widget construct(BuildContext context, bool expanded, String searchString) {
    return ExpansionTile(
        key: UniqueKey(),
        //todo check why it wont rebuild without this when initially changes. possible bug
        initiallyExpanded: expanded,
        leading: Container(
          child: Text(issue),
        ),
        title: Text(title),
        trailing: CircleAvatar(
          child: Text(_atomicTypeInitial(atomicType)),
        ),
        children: toys);
  }

  String _atomicTypeInitial(AtomicType atomicType) {
    switch (atomicType) {
      case AtomicType.atom:
        return "A";
      case AtomicType.molecule:
        return "M";
      case AtomicType.organism:
        return "O";
      case AtomicType.template:
        return "T";
      case AtomicType.page:
        return "P";
      default:
        return null;
    }
  }
}

class Toy extends StatelessWidget {
  final WidgetBuilder childBuilder;
  final String variation;
  final bool disableScaffold;
  final bool resizable;

  const Toy(
      {@required this.childBuilder,
      @required this.variation,
        this.disableScaffold = false,
      this.resizable = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(variation),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
          disableScaffold
              ? buildBody(context)
              : Scaffold(
            appBar: AppBar(
              title: Text(variation),
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
