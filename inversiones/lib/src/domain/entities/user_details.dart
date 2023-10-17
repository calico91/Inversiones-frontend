import 'package:inversiones/src/domain/entities/Authority.dart';

class UserDetails {
  const UserDetails({
    this.password,
    required this.username,
    required this.authorities,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
    required this.enabled,
  });

  final String? password;
  final String username;
  final List<Authority> authorities;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;
  final bool enabled;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        password: json["password"] == null ? "" : json["password"] as String,
        username: json["username"] as String,
        authorities: List<Authority>.from(
          (json["authorities"] as List<dynamic>).map((element) {
            return Authority.fromJson(element as Map<String, dynamic>);
          }),
        ),
        accountNonExpired: json["accountNonExpired"] as bool,
        accountNonLocked: json["accountNonLocked"] as bool,
        credentialsNonExpired: json["credentialsNonExpired"] as bool,
        enabled: json["enabled"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "username": username,
        "authorities": authorities,
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
        "enabled": enabled,
      };
}
