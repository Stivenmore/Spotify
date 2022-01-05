import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:spotify/Domain/Logic/Spotify/AbstractProvider.dart';
import 'package:spotify/Domain/Models/Stander/albumModel.dart';
import 'package:spotify/Domain/Models/Stander/categoriesModel.dart';
import 'package:spotify/Domain/Models/Stander/playlistModel.dart';

class SpotifyProvider with ChangeNotifier {
  final AbstractProvider abstractProvider;

  SpotifyProvider(this.abstractProvider) {
    getCategoria();
    getRecomendationAlbums();
    getRecomendationPlays();
  }
  //
  bool globalstate = false;
  bool get globalstates => globalstate;
  int errornumber = 0;
  int get errornumbers => errornumber;
  //

  //Screen Principal
  List<CategoriesModel> categoriesModel = [];
  List<AlbumModel> albumModel = [];
  List<PlaylistModel> playListModel = [];
  int offsetCategoriaReco = 0;
  int offsetPlayReco = 0;
  //

  //Options selected
  List<PlaylistModel> playListOptModel = [];
  int offsetOptPlayReco = 0;
  //

  void funcionprogress() {
    globalstate = true;
    notifyListeners();
  }

  void funcionstop() {
    globalstate = false;
    notifyListeners();
  }

  void pluserror() {
    errornumber++;
    notifyListeners();
  }

  void clearerror() {
    errornumber = 0;
    notifyListeners();
  }

  void clearOPT() {
    playListOptModel = [];
    offsetOptPlayReco = 0;
  }

  Future getCategoria() async {
    try {
      List<CategoriesModel> auxiliar;
      final resp = await abstractProvider.getCategories(
          locale: 'sv_SE', country: 'AU', offset: offsetCategoriaReco++);
      if (resp != null && resp["categories"]['next'] != null) {
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
      pluserror();
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future getRecomendationAlbums() async {
    try {
      final resp = await abstractProvider.gerrecomenCate(
          market: 'ES',
          ids:
              '7ouMYWpwJ422jRcDASZB7P,4VqPOruhp5EdPBeR92t6lQ,2takcwOaAZWiXQijPHIx7B');
      if (resp != null && resp["categories"]['next'] != null) {
        albumModel = (resp["tracks"] as Iterable)
            .map((e) => AlbumModel.fromJson(e))
            .toList();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      pluserror();
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future getRecomendationPlays() async {
    try {
      List<PlaylistModel> auxiliar;
      final resp = await abstractProvider.getrecomenPlays(
          categoryID: 'rock', country: 'AU', offset: offsetPlayReco++);
      if (resp != null && resp["categories"]['next'] != null) {
        auxiliar = (resp["playlists"]["items"] as Iterable)
            .map((e) => PlaylistModel.fromJson(e))
            .toList();

        playListModel = [...playListModel, ...auxiliar];
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      pluserror();
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future getPlayListOpt({required String categoryID}) async {
    try {
      funcionprogress();
      List<PlaylistModel> auxiliar;
      final resp = await abstractProvider.getrecomenPlays(
          categoryID: categoryID, country: 'AU', offset: offsetOptPlayReco++);
      if (resp != null && resp["categories"]['next'] != null) {
        auxiliar = (resp["playlists"]["items"] as Iterable)
            .map((e) => PlaylistModel.fromJson(e))
            .toList();
        playListOptModel = [...playListOptModel, ...auxiliar];
        notifyListeners();
        funcionstop();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      pluserror();
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
