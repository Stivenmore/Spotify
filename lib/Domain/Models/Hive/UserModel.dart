import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  UserModel(
      {required this.identification,
      required this.name,
      required this.email,
      required this.lastname});

  @HiveField(0)
  String? identification;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? lastname;

  @HiveField(3)
  String? email;
}

// flutter pub run build_runner build --delete-conflicting-outputs
// El comando anterior se utiliza para generar el codigo HIVE para BDLocal