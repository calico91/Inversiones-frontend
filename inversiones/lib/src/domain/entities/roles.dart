class Roles {
  const Roles({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Roles.fromJson(Map<String, dynamic> json) =>
      Roles(id: json['id'] as int, name: json['name'] as String);

  Map<String, dynamic> toJson() {
    return {if (id != 0) 'id': id, 'name': name};
  }
}
