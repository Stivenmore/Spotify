import 'package:spotify/Domain/Models/Stander/tracksModel.dart';

class SearchModelTrack {
  final String? href;
  final String? id;
  final String? name;
  final List<IconModel>? images;
  final List<ArtisModel>? artists;
  final String? previusURl;

  SearchModelTrack(
      {required this.artists,
      required this.images,
      required this.name,
      required this.href,
      required this.id,
      required this.previusURl});

  factory SearchModelTrack.fromJson(Map<String, dynamic> map) {
    final list = List.from(map["album"]['images'] ?? []);
    final list2 = List.from(map['artists'] ?? []);

    return SearchModelTrack(
        previusURl: map['preview_url'] as String? ??
            'https://p.scdn.co/mp3-preview/9d11cad0938d802d892423354c56565fd95b1d23?cid=774b29d4f13844c495f206cafdad9c86',
        href: map['href'] as String? ?? ' ',
        id: map['id'] as String? ?? ' ',
        name: map["name"] as String? ?? ' ',
        images: list.isNotEmpty
            ? list.map((e) => IconModel.fromJson(e)).toList()
            : [],
        artists: list2.isNotEmpty
            ? list2.map((e) => ArtisModel.fromJson(e)).toList()
            : []);
  }
}
