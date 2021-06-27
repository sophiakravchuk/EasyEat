import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._privateConstructor();
  factory LocalStorage() {
    return _instance;
  }
  SharedPreferences _prefs;

  LocalStorage._privateConstructor() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  getRecipe(id) {
    try {
      return _prefs.getString(id) ?? 0;
    } catch (error) {
      return 0;
    }
  }

  setRecipe(String id, String recipe) {
    try {
      _prefs.setString(id, recipe);
    } catch (error) {
      return;
    }
  }

  removeRecipe(String id) {
    try {
      _prefs.remove(id);
    } catch (error) {
      return;
    }
  }

  getAllKeys() {
    try {
      return _prefs.getKeys();
    } catch (error) {
      return;
    }
  }

  getByKey(String id) {
    try {
      return _prefs.get(id);
    } catch (error) {
      return;
    }
  }
}
