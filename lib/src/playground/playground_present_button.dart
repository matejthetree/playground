import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundPresentButton extends StatelessWidget {
  final Widget child;
  final Function(Widget, BuildContext) present;

  const PlaygroundPresentButton({
    Key key,
    Function(Widget, BuildContext) listener,
    Widget child,
  })  : this.present = listener,
        this.child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text("Press Me"),
        onPressed: () => present(child, context),
      ),
    );
  }

  static presentModal(Widget modal, BuildContext context) {

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ModalNavigator(child: modal),
    );
  }
}

//todo discuss the separation of this common library
class ModalNavigator extends StatelessWidget {
  ModalNavigator({
    @required this.child,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKey.currentState.maybePop(),
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder = (BuildContext _) => child;
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ),
      ),
    );
  }
}
