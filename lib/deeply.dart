library deeply;

dynamic deepUpdate(List keyPath, dynamic data, Function updater,
    [int i = 0, dynamic notSetValue = null]) {
  if (i == keyPath.length) {
    return updater(data == null ? notSetValue : data);
  }

  if (!(data is Map)) {
    data = {};
  }

  data = new Map<dynamic, dynamic>.from(data);

  data[keyPath[i]] = deepUpdate(keyPath, data[keyPath[i]], updater, ++i);

  return data;
}
