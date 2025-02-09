import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  static const cartBox = 'cartBox';
  static const productsBox = 'productsBox';
}

class HiveCacheHelper {
  static final Map<String, Box> _openBoxes = {};

  //listen to hive box
  static Future<Stream> listen<T>(String boxName) async {
    final box = await openBox(boxName);
    return box.watch();
  }

  /// Opens a Hive box or retrieves an already opened one
  static Future<Box<T>> openBox<T>(String boxName) async {
    if (_openBoxes.containsKey(boxName) && Hive.isBoxOpen(boxName)) {
      return _openBoxes[boxName] as Box<T>;
    }
    final box = await Hive.openBox<T>(boxName);
    _openBoxes[boxName] = box;
    return box;
  }

  /// Adds an item to the box
  static Future<void> addItem<T>(String boxName, int key, T item) async {
    final box = await openBox<T>(boxName);
    await box.put(key, item);
  }

  /// Adds multiple items to the box
  static Future<void> addItems<T>(String boxName, Map<int, T> items) async {
    final box = await openBox<T>(boxName);
    await box.putAll(items);
  }

  /// Retrieves an item by key
  static Future<T?> getItem<T>(String boxName, int key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  /// Retrieves items matching one condition
  static Future<List<T>> getItemsByCondition<T>(
      String boxName, bool Function(T) condition) async {
    final box = await openBox<T>(boxName);
    return box.values.where(condition).toList();
  }

  /// Retrieves All items
  static Future<List<T>> getItems<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName).values.toList();
    } else {
      final box = await openBox<T>(boxName);
      return box.values.toList();
    }
  }

  /// Retrieves items matching multiple conditions
  static Future<List<T>> getItemsByConditions<T>(
      String boxName, List<bool Function(T)> conditions) async {
    final box = await openBox<T>(boxName);
    return box.values.where((item) {
      for (var condition in conditions) {
        if (!condition(item)) return false;
      }
      return true;
    }).toList();
  }

  /// Deletes an item by key
  static Future<void> deleteItem<T>(String boxName, int key) async {
    final box = await openBox<T>(boxName);
    await box.delete(key);
  }

  ///Delete box data
  static Future<void> deleteBoxFromDisk<T>(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }

  /// Edits an item in the box by key
  static Future<void> editItem<T>(
      String boxName, int key, T updatedItem) async {
    final box = await openBox<T>(boxName);
    if (box.containsKey(key)) {
      await box.put(key, updatedItem);
    } else {
      throw Exception("Item with key $key does not exist in the box.");
    }
  }

  /// Updates a specific field in an item by key
  static Future<void> updateField<T>(
      String boxName, int key, void Function(T item) updateCallback) async {
    final box = await openBox<T>(boxName);
    final item = box.get(key);

    if (item == null) {
      throw Exception("Item with key $key does not exist in the box.");
    }

    // Update the item's field using the provided callback
    updateCallback(item);

    // Save the updated item back to the box
    await box.put(key, item);
  }

  /// Closes a specific box
  static Future<void> closeBox(String boxName) async {
    if (_openBoxes.containsKey(boxName)) {
      await _openBoxes[boxName]!.close();
      _openBoxes.remove(boxName);
    }
  }

  /// Closes all opened boxes
  static Future<void> closeAllBoxes() async {
    for (var box in _openBoxes.values) {
      await box.close();
    }
    _openBoxes.clear();
  }
}
