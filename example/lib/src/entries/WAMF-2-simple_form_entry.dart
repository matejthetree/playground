import 'package:wamf_playground/wamf_playground.dart';
import '../ui/my_custom_form.dart';

class WAMF_2_SimpleFormEntry extends PlaygroundEntry {
  @override
  List<AtomicPlaygroundComponent> get components => [
      AtomicPlaygroundComponent(
          type: AtomicType.molecule,
          title: "WAMF-2 Form Molecule",
          component: MyCustomForm()),
    ];
}

