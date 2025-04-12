// import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:blogging_app/core/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.name,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? "",
      email: map["email"] ?? "",
      name: map["name"] ?? "",
    );
  }

  UserModel copyWith({
    String? email,
    String? name,
    String? id,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
