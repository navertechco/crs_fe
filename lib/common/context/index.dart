// ignore_for_file: non_constant_identifier_names
import 'package:property_change_notifier/property_change_notifier.dart';

// ignore: mixin_inherits_from_not_object
class Context with PropertyChangeNotifier<String> {
  void set_context(key, value) {
    context[key] = value;
    notifyListeners(key);
  }

  dynamic get_context(key) {
    return context[key];
  }

  Map<String, dynamic> context = ({
    "index": 0,
    "icons": {},
    "countries": {},
    "session": {"avatar": ''},
    "catalogs": {}
  });
}
