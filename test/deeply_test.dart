import 'package:test/test.dart';

import 'package:deeply/deeply.dart';

void main() {
  test('update with keypath', () {
    Map<dynamic, dynamic> data = {
      "name": {"first": "First", "last": "Last"},
      "birthday": {"day": 11, "month": 2, "year": 1997},
      "config": "test",
    };

    data = deepUpdate(["name", "first"], data, (name) => name += " Second");
    data = deepUpdate(["birthday", "month"], data, (month) => ++month);
    data = deepUpdate(["config", "active"], data, (_) => true);

    expect(data, {
      "name": {"first": "First Second", "last": "Last"},
      "birthday": {"day": 11, "month": 3, "year": 1997},
      "config": {"active": true},
    });
  });
}
