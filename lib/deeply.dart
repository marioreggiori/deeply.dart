library deeply;

dynamic updateDeeply(List keyPath, dynamic data, Function updater,
    [dynamic notSetValue, int i = 0]) {
  if (i == keyPath.length) {
    return updater(data == null ? notSetValue : data);
  }

  if (!(data is Map)) {
    data = {};
  }

  data = Map<dynamic, dynamic>.from(data);

  data[keyPath[i]] =
      updateDeeply(keyPath, data[keyPath[i]], updater, notSetValue, ++i);

  return data;
}

dynamic removeDeeply(List keyPath, dynamic data, [int i = 0]) {
  if (data is Map) {
    if (!data.containsKey(keyPath[i])) {
      return data;
    } else {
      if (keyPath.length == i + 1) {
        data.remove(keyPath[i]);
        return data;
      }
    }
  } else {
    return data;
  }
  data[keyPath[i]] = removeDeeply(keyPath, data[keyPath[i]], ++i);

  return data;
}

dynamic renameDeeply(List keyPath, dynamic newKey, dynamic data, [int i = 0]) {
  if (data is Map) {
    if (!data.containsKey(keyPath[i])) {
      return data;
    } else {
      if (keyPath.length == i + 1) {
        data[newKey] = data[keyPath[i]];
        data.remove(keyPath[i]);
        return data;
      }
    }
  } else {
    return data;
  }

  data[keyPath[i]] = renameDeeply(keyPath, newKey, data[keyPath[i]], ++i);

  return data;
}
