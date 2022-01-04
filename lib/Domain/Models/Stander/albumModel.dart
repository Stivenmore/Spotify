class AlbumModel {
  final String? href;
  final String? id;
  final String? name;
  final List<IconModel>? images;
  final List<ArtisModel>? artists;

  AlbumModel({
    required this.artists,
    required this.images,
    required this.name,
    required this.href,
    required this.id,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> map) {
    final list = List.from(map["album"]['images'] ?? []);
    final list2 = List.from(map["album"]['artists'] ?? []);

    return AlbumModel(
        href: map["album"]['href'] as String? ?? '',
        id: map["album"]['id'] as String? ?? '',
        name: map["album"]["name"] as String? ?? '',
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
      urlSpotify: map["external_urls"]["spotify"],
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
