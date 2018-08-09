import 'package:test/test.dart';

import 'package:deeply/deeply.dart';

void main() {
  test('update', () {
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

  test('remove', () {
    Map<dynamic, dynamic> data = {
      "name": {"first": "First", "last": "Last"},
      "birthday": {"day": 11, "month": 2, "year": 1997},
      "config": "test",
    };

    data = removeDeeply(["birthday", "month"], data);
    data = removeDeeply(["name"], data);
    data = removeDeeply(["o", "x"], data);

    expect(data, {
      "birthday": {"day": 11, "year": 1997},
      "config": "test",
    });
  });

  test('rename', () {
    Map<dynamic, dynamic> data = {
      "name": {"first": "First", "last": "Last"},
      "birthday": {"day": 11, "month": 2, "year": 1997},
      "config": "test",
    };

    data = renameDeeply(["name"], "Name", data);
    data = renameDeeply(["birthday", "month"], "monat", data);
    data = renameDeeply(["birthday", "month", "toast"], "blub", data);
    data = renameDeeply(["a", "toast"], "o", data);

    expect(data, {
      "Name": {"first": "First", "last": "Last"},
      "birthday": {"day": 11, "monat": 2, "year": 1997},
      "config": "test",
    });
  });
}
