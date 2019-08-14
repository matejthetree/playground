import 'package:flutter/widgets.dart';
import 'package:wamf_playground/src/playground/data/playground_data_source.dart';
import 'package:wamf_playground/src/playground/playground_view.dart';
import 'package:wamf_playground/src/playground/playground_widget.dart';
import 'package:wamf_playground/wamf_playground.dart';

enum AtomicType { atom, molecule, organism, template, page }

class _Strings {
  static const atomTitle = "Atom";
  static const moleculeTitle = "Molecule";
  static const organismTitle = "Organism";
  static const templateTitle = "Template";
  static const pageTitle = "Page";
}

class AtomicPlaygroundComponent {
  final AtomicType type;
  final String title;
  final Widget component;

  AtomicPlaygroundComponent(
      {@required AtomicType type,
      @required String title,
      @required Widget component})
      : this.title = title,
        this.type = type,
        this.component = component;

  Widget asPlaygroundWidget() {
    return PlaygroundWidget(
      child: component,
      title: title,
    );
  }

}

class AtomicPlaygroundDatasource implements PlaygroundDataSource {
  List<PlaygroundEntry> entries;
  Iterable<AtomicPlaygroundComponent> _components;

  AtomicPlaygroundDatasource(this.entries)
      : _components = entries.expand((entry) => [...entry.components]);

  @override
  List<Widget> getAtomicList() {
    return [
      PlaygroundWidget(
        title: _Strings.atomTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.atom)),
      ),
      PlaygroundWidget(
        title: _Strings.moleculeTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.molecule)),
      ),
      PlaygroundWidget(
        title: _Strings.organismTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.organism)),
      ),
      PlaygroundWidget(
        title: _Strings.templateTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.template)),
      ),
      PlaygroundWidget(
        title: _Strings.pageTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.page)),
      ),
    ];
  }

  List<Widget> _generateFor(AtomicType type) => _components.where((component) {
        return component.type == type;
      }).map((component) {
        return component.asPlaygroundWidget();
      }).toList();
}
