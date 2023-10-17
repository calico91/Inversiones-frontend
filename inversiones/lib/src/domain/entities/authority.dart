class Authority {
  String authority;

  Authority({
    required this.authority,
  });

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        authority: json["authority"] as String,
      );

  Map<String, dynamic> toJson() => {
        "authority": authority,
      };
}
