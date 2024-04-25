class UserDetails {
  UserDetails(
      {this.password,
      this.username,
      this.authorities,
      this.accountNonExpired,
      this.accountNonLocked,
      this.credentialsNonExpired,
      this.enabled,
      this.token,
      this.id});

  String? password;
  final String? username;
  final List<String>? authorities;
  final bool? accountNonExpired;
  final bool? accountNonLocked;
  final bool? credentialsNonExpired;
  final bool? enabled;
  final String? token;
  final int? id;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        password: json["password"] == null ? "" : json["password"] as String,
        username: json["username"] as String,
        authorities: List<String>.from(json["authorities"] == null
            ? []
            : json["authorities"] as List<dynamic>),
        accountNonExpired: json["accountNonExpired"] == null ||
            json["accountNonExpired"] as bool,
        accountNonLocked: json["accountNonLocked"] == null ||
            json["accountNonLocked"] as bool,
        credentialsNonExpired: json["credentialsNonExpired"] == null ||
            json["credentialsNonExpired"] as bool,
        enabled: json["enabled"] == null || json["enabled"] as bool,
        token: json["token"] == null ? "" : json["token"] as String,
        id: json["id"] == null ? 0 : json["id"] as int,
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "username": username,
        "authorities": authorities,
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
        "enabled": enabled,
        "token": token,
        "id": id,
      };
}
