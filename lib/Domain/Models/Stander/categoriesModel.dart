class CategoriesModel {
  final String? href;
  final String? id;
  final String? name;
  final List<IconModel>? iconlist;

  CategoriesModel({
    required this.iconlist,
    required this.name,
    required this.href,
    required this.id,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> map) {
    final list = List.from(map['icons'] ?? []);

    return CategoriesModel(
        href: map['href'] as String? ?? '',
        id: map['id'] as String? ?? '',
        name: map["name"] as String? ?? '',
        iconlist: list.isNotEmpty
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
