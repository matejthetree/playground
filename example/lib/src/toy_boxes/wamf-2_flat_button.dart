import 'package:example/src/ui/my_custom_form.dart';
import 'package:wamf_playground/wamf_playground.dart';

class SimpleFormToyBox extends ToyBox {
  SimpleFormToyBox()
      : super(
            atomicType: AtomicType.molecule,
            issue: "WAMF-2",
            title: "Form Molecule",
            toys: [
              Toy(
                childBuilder: (context) => MyCustomForm(),
                variation: "Default Style",
              )
            ]);
}
