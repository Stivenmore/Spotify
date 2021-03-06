// ignore_for_file: avoid_print, prefer_final_fields

import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/Domain/Logic/Spotify/AbstractProvider.dart';
import 'package:spotify/Domain/Shared/prefs.dart';
import 'package:spotify/Views/Utils/Global/keys.dart';

@Named('Env.dev')
@Injectable(as: AbstractProvider)
@injectable
class SpotifyRepository implements AbstractProvider {
  final _prefs = UserPreferences();
  int limit = 18;

  @override
  Future tokenizacion() async {
    try {
      if (_prefs.oatoken == '' && _prefs.expirestoken != DateTime.now().hour ||
          _prefs.oatoken.isNotEmpty &&
              _prefs.expirestoken != DateTime.now().hour) {
        print(DateTime.now().hour);
        var credentials = "$client_id:$client_secret";
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        String encoded = stringToBase64.encode(credentials);
        var body2 = "grant_type=client_credentials";
        var body = "grant_type=client_credentials&client_id=$client_id";
        final resp = await http.post(Uri.parse(urlAoToken),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Authorization": "Basic $encoded"
            },
            body: body2);
        if (resp.statusCode == 200) {
          var data = json.decode(resp.body);
          _prefs.oatoken = data['access_token'];
          _prefs.expirestoken = DateTime.now().hour;
          print(_prefs.oatoken);
          print(_prefs.expirestoken);
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getCategories(
      {required String locale,
      required String country,
      required int offset}) async {
    try {
      final tokenizate = await tokenizacion();
      if (tokenizate == true) {
        final resp = await http.get(
          Uri.parse(
              '$urlbasic/browse/categories?country=$country&locale=$locale&limit=$limit&offset=$offset'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${_prefs.oatoken}",
          },
        );
        if (resp.statusCode == 200) {
          return json.decode(resp.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future gerrecomenCate({required String market, required String ids}) async {
    try {
      final tokenizate = await tokenizacion();
      if (tokenizate == true) {
        final resp = await http.get(
          Uri.parse('$urlbasic/tracks?market=$market&ids=$ids'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${_prefs.oatoken}",
          },
        );
        if (resp.statusCode == 200) {
          return json.decode(resp.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getrecomenPlays(
      {required String categoryID,
      required String country,
      required int offset}) async {
    try {
      final tokenizate = await tokenizacion();
      if (tokenizate == true) {
        final resp = await http.get(
          Uri.parse(
              '$urlbasic/browse/categories/$categoryID/playlists/?country=$country&limit=$limit&offset=$offset'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${_prefs.oatoken}",
          },
        );
        if (resp.statusCode == 200) {
          return json.decode(resp.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getallTracks({
    required String playlistID,
    required int offset,
  }) async {
    try {
      final tokenizate = await tokenizacion();
      if (tokenizate == true) {
        final resp = await http.get(
          Uri.parse(
              '$urlbasic/playlists/$playlistID/tracks?&limit=$limit&offset=$offset'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${_prefs.oatoken}",
          },
        );
        if (resp.statusCode == 200) {
          return json.decode(resp.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getSingleTrack({required String id}) async {
    try {
      final tokenizate = await tokenizacion();
      if (tokenizate == true) {
        final resp = await http.get(
          Uri.parse('$urlbasic/tracks/$id'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${_prefs.oatoken}",
          },
        );
        if (resp.statusCode == 200) {
          return json.decode(resp.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getSingleArtist({required String id}) async {
    try {
      final tokenizate = await tokenizacion();
      if (tokenizate == true) {
        final resp = await http.get(
          Uri.parse('$urlbasic/artists/$id'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${_prefs.oatoken}",
          },
        );
        if (resp.statusCode == 200) {
          return json.decode(resp.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getTopTracksArtist({required String id}) async {
    try {
      final tokenizate = await tokenizacion();
      if (tokenizate == true) {
        final resp = await http.get(
          Uri.parse('$urlbasic/artists/$id/top-tracks?market=ES'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${_prefs.oatoken}",
          },
        );
        if (resp.statusCode == 200) {
          return json.decode(resp.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getSearchTracks({required String q, required int offset}) async {
    try {
      final tokenizate = await tokenizacion();
      if (tokenizate == true) {
        String track = 'track';
        final resp = await http.get(
          Uri.parse(
              '$urlbasic/search?q=$q&type=track&market=ES&limit=50&offset=0'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${_prefs.oatoken}",
          },
        );
        if (resp.statusCode == 200) {
          return json.decode(resp.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
