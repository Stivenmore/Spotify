class PlaylistModel {
  final String? href;
  final String? id;
  final String? name;
  final String? description;
  final List<IconModel>? images;
  final String? trackreference;
  final bool? collaborative;

  PlaylistModel(
      {required this.images,
      required this.collaborative,
      required this.name,
      required this.href,
      required this.id,
      required this.description,
      required this.trackreference});

  factory PlaylistModel.fromJson(Map<String, dynamic> map) {
    final list = List.from(map['images'] ?? []);

    return PlaylistModel(
        collaborative: map["collaborative"] as bool? ?? false,
        trackreference: map["tracks"]["href"] as String? ?? '',
        description: map["description"] ?? '',
        href: map['href'] as String? ?? '',
        id: map['id'] as String? ?? '',
        name: map["name"] as String? ?? '',
        images: list.isNotEmpty
            ? list.map((e) => IconModel.fromJson(e)).toList()
            : []);
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
