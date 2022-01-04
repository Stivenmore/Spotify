import 'package:flutter/foundation.dart';
import 'package:spotify/Domain/Logic/Spotify/AbstractProvider.dart';
import 'package:spotify/Domain/Models/Stander/albumModel.dart';
import 'package:spotify/Domain/Models/Stander/categoriesModel.dart';

class SpotifyProvider with ChangeNotifier {
  final AbstractProvider abstractProvider;

  SpotifyProvider(this.abstractProvider) {
    getCategoria();
    getRecomendationAlbums();
  }

  List<CategoriesModel> categoriesModel = [];
  List<AlbumModel> albumModel = [];
  int offsetCategoria = -1;

  Future getCategoria() async {
    try {
      List<CategoriesModel> auxiliar;
      final resp = await abstractProvider.getCategories(
          locale: 'sv_SE', country: 'AU', offset: offsetCategoria++);
      if (resp != null) {
        auxiliar = (resp["categories"]["items"] as Iterable)
            .map((e) => CategoriesModel.fromJson(e))
            .toList();
        categoriesModel = [...categoriesModel, ...auxiliar];
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future getRecomendationAlbums() async {
    try {
      final resp = await abstractProvider.gerrecomenPlays(
          market: 'ES',
          ids:
              '7ouMYWpwJ422jRcDASZB7P,4VqPOruhp5EdPBeR92t6lQ,2takcwOaAZWiXQijPHIx7B');
      if (resp != null) {
        albumModel = (resp["tracks"] as Iterable)
            .map((e) => AlbumModel.fromJson(e))
            .toList();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
