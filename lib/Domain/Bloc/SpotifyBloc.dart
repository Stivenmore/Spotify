import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:spotify/Domain/Logic/Spotify/AbstractProvider.dart';
import 'package:spotify/Domain/Models/Stander/albumModel.dart';
import 'package:spotify/Domain/Models/Stander/artistModel.dart';
import 'package:spotify/Domain/Models/Stander/categoriesModel.dart';
import 'package:spotify/Domain/Models/Stander/playlistModel.dart';
import 'package:spotify/Domain/Models/Stander/trackArtistModel.dart';
import 'package:spotify/Domain/Models/Stander/tracksModel.dart';
import 'package:spotify/Domain/Shared/prefs.dart';

class SpotifyProvider with ChangeNotifier {
  final AbstractProvider abstractProvider;
  final _prefs = UserPreferences();

  SpotifyProvider(this.abstractProvider) {
    getCategoria();
    getRecomendationAlbums();
    getRecomendationPlays();
  }

  ///
  bool globalstate = false;
  bool get globalstates => globalstate;
  int errornumber = 0;
  int get errornumbers => errornumber;

  ///

  //Screen Principal
  List<CategoriesModel> categoriesModel = [];
  List<AlbumModel> albumModel = [];
  List<PlaylistModel> playListModel = [];
  int offsetCategoriaReco = 0;
  int offsetPlayReco = 0;
  //

  ///Options selected
  List<PlaylistModel> playListOptModel = [];
  int offsetOptPlayReco = 0;
  List<TrackModel> trackListOptModel = [];
  int offsetOptTrack = 0;

  ///

  //Funtions
  void funcionprogress() {
    globalstate = true;
    notifyListeners();
  }

  void funcionstop() {
    globalstate = false;
    notifyListeners();
  }

  ///

  ///Errors
  void pluserror() {
    errornumber++;
    notifyListeners();
  }

  ///

  /// Clear
  void clearerror() {
    errornumber = 0;
    notifyListeners();
  }

  void clearOPTPlays() {
    playListOptModel = [];
    offsetOptPlayReco = 0;
    notifyListeners();
  }

  void clearOPTTrack() {
    offsetOptTrack = 0;
    trackListOptModel = [];
    notifyListeners();
  }

  ///

  Future getCategoria() async {
    try {
      List<CategoriesModel> auxiliar;
      final resp = await abstractProvider.getCategories(
          locale: 'sv_SE',
          country: _prefs.locale,
          offset: offsetCategoriaReco++);
      List items = resp["categories"]["items"];
      if (resp != null && items != []) {
        auxiliar = (resp["categories"]["items"] as Iterable)
            .map((e) => CategoriesModel.fromJson(e))
            .toList();
        categoriesModel = [...categoriesModel, ...auxiliar];
        items = [];
        auxiliar = [];
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
          categoryID: 'rock', country: _prefs.locale, offset: offsetPlayReco++);
      List items = resp["playlists"]["items"];
      if (resp != null && items != []) {
        auxiliar = (resp["playlists"]["items"] as Iterable)
            .map((e) => PlaylistModel.fromJson(e))
            .toList();

        playListModel = [...playListModel, ...auxiliar];
        items = [];
        auxiliar = [];
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
          categoryID: categoryID,
          country: _prefs.locale,
          offset: offsetOptPlayReco++);
      List? items = resp["playlists"]["items"];
      if (resp != null && items != []) {
        auxiliar = (resp["playlists"]["items"] as Iterable)
            .map((e) => PlaylistModel.fromJson(e))
            .toList();
        playListOptModel = [...playListOptModel, ...auxiliar];
        auxiliar = [];
        items = [];
        notifyListeners();
        funcionstop();
        return true;
      } else {
        funcionstop();
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

  Future getTrackListOpt({required String playlistID}) async {
    try {
      funcionprogress();
      List<TrackModel> auxiliar;
      final resp = await abstractProvider.getallTracks(
          playlistID: playlistID, offset: offsetOptTrack++);
      List? items = resp["items"];
      if (resp != null && items != []) {
        auxiliar = (resp["items"] as Iterable)
            .map((e) => TrackModel.fromJson(e))
            .toList();
        trackListOptModel = [...trackListOptModel, ...auxiliar];
        auxiliar = [];
        notifyListeners();
        funcionstop();
        return true;
      } else {
        funcionstop();
        return false;
      }
    } catch (e) {
      funcionstop();
      pluserror();
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<ArtistsModel?> getArtistSimple({required String id}) async {
    try {
      funcionprogress();
      final resp = await abstractProvider.getSingleArtist(id: id);
      if (resp != null) {
        ArtistsModel artisListOptModel = ArtistsModel.fromJson(resp);
        notifyListeners();
        funcionstop();
        return artisListOptModel;
      } else {
        funcionstop();
        return null;
      }
    } catch (e) {
      funcionstop();
      return null;
    }
  }

  Future<List<TrackArtistModel>?> getArtistAlbumAndTrack(
      {required String id}) async {
    try {
      funcionprogress();
      final resp = await abstractProvider.getTopTracksArtist(id: id);
      if (resp != null) {
        List<TrackArtistModel> model = (resp["tracks"] as Iterable)
            .map((e) => TrackArtistModel.fromJson(e))
            .toList();
        notifyListeners();
        funcionstop();
        return model;
      } else {
        funcionstop();
        return null;
      }
    } catch (e) {
      funcionstop();
      pluserror();
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
