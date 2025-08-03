import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? photoUrl;
  final DateTime? createdAt;

  const AppUser({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
    this.createdAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  AppUser copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, email, name, photoUrl, createdAt];

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, name: $name)';
  }
}

// class UserData extends Equatable {
//   const UserData(
//     this.platinoId,
//     this.names,
//     this.code,
//     this.emails,
//     this.roles,
//   );

//   final String platinoId;
//   final String names;
//   final String code;
//   final List<String> emails;
//   final List<String> roles;

//   bool get isAdmin => roles.contains(OneRole.admin);
//   // bool get isAdmin => roles.contains(dotenv.env["ONE_ADMIN"]);
//   bool get hasMultiRole => roles.length > 1;
//   factory UserData.fromJson(Map<String, dynamic> json) =>
//       _$UserDataFromJson(json);

//   Map<String, dynamic> toJson() => _$UserDataToJson(this);

//   @override
//   List<Object?> get props => [platinoId, names, code, roles];
// }
