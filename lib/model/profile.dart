class Profile {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String address;
  final String photo;

  Profile({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.photo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: int.parse(json['user_id'] ?? "0"),
      name: json['name'],
      username: json['username'] ?? '',
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      photo: json['photo'],
    );
  }
}
