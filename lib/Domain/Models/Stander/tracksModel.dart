class TrackModel {
  final String? href;
  final String? id;
  final String? name;
  final List<IconModel>? images;
  final List<ArtisModel>? artists;
  final String? previusURl;

  TrackModel(
      {required this.artists,
      required this.images,
      required this.name,
      required this.href,
      required this.id,
      required this.previusURl});

  factory TrackModel.fromJson(Map<String, dynamic> map) {
    final list = List.from(map["track"]["album"]['images'] ?? []);
    final list2 = List.from(map["track"]['artists'] ?? []);

    return TrackModel(
        previusURl: map["track"]['preview_url'] as String? ??
            'https://p.scdn.co/mp3-preview/9d11cad0938d802d892423354c56565fd95b1d23?cid=774b29d4f13844c495f206cafdad9c86',
        href: map["track"]['href'] as String? ?? ' ',
        id: map["track"]['id'] as String? ?? ' ',
        name: map["track"]["name"] as String? ?? ' ',
        images: list.isNotEmpty
            ? list.map((e) => IconModel.fromJson(e)).toList()
            : [],
        artists: list2.isNotEmpty
            ? list2.map((e) => ArtisModel.fromJson(e)).toList()
            : []);
  }
}

class ArtisModel {
  final String? href;
  final String? id;
  final String? name;
  final String? urlSpotify;

  ArtisModel({
    required this.urlSpotify,
    required this.name,
    required this.href,
    required this.id,
  });

  factory ArtisModel.fromJson(Map<String, dynamic> map) {
    return ArtisModel(
      urlSpotify: map["external_urls"]["spotify"] as String? ?? '',
      href: map['href'] as String? ?? '',
      id: map['id'] as String? ?? '',
      name: map["name"] as String? ?? '',
    );
  }
}

class IconModel {
  final int? height;
  final String? url;
  final int? width;

  IconModel({
    required this.height,
    required this.url,
    required this.width,
  });

  factory IconModel.fromJson(Map<String, dynamic> map) {
    return IconModel(
        height: map['height'] as int? ?? 274,
        url: map['url'] as String? ?? '',
        width: map["width"] as int? ?? 274);
  }
}
