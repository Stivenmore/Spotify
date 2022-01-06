class ArtistsModel {
  final String? href;
  final String? id;
  final String? name;
  final List<ImageModel>? iconlist;

  ArtistsModel({
    required this.iconlist,
    required this.name,
    required this.href,
    required this.id,
  });

  factory ArtistsModel.fromJson(Map<String, dynamic> map) {
    final list = List.from(map['images'] ?? []);

    return ArtistsModel(
        href: map['href'] as String? ?? '',
        id: map['id'] as String? ?? '',
        name: map["name"] as String? ?? '',
        iconlist: list.isNotEmpty
            ? list.map((e) => ImageModel.fromJson(e)).toList()
            : []);
  }
}

class ImageModel {
  final int? height;
  final String? url;
  final int? width;

  ImageModel({
    required this.height,
    required this.url,
    required this.width,
  });

  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
        height: map['height'] as int? ?? 274,
        url: map['url'] as String? ?? '',
        width: map["width"] as int? ?? 274);
  }
}
