import 'package:blog/core/common/entities/user.dart';

class UserModel extends User {
  UserModel(
    super.id,
    super.username,
    super.email,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['id'] ?? "",
      json['name'] ?? "",
      json['email'] ?? "",
    );
  }
}
