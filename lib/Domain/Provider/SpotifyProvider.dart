import 'package:flutter/foundation.dart';
import 'package:spotify/Domain/Logic/Spotify/AbstractProvider.dart';
import 'package:spotify/Domain/Models/Stander/categoriesModel.dart';

class SpotifyProvider with ChangeNotifier {
  final AbstractProvider abstractProvider;

  SpotifyProvider(this.abstractProvider) {
    getCategoria();
  }

  List<CategoriesModel> categoriesModel = [];
  int offsetCategoria = -1;

  Future getCategoria() async {
    try {
      List<CategoriesModel> auxiliar;
      final resp = await abstractProvider.getCategories(
          locale: 'CO', country: '', offset: offsetCategoria++);
      auxiliar = (resp["items"] as Iterable)
          .map((e) => CategoriesModel.fromJson(e))
          .toList();
      categoriesModel = [...categoriesModel, ...auxiliar];
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
