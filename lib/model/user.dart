class User {
  final String name;
  final String email;
  final String phoneNumber;
  final String? imageUrl;
  User(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.imageUrl});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'imageUrl': imageUrl,
      };
  factory User.fromJson(Map<dynamic, dynamic> json) => User(
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        imageUrl: json['imageUrl'],
      );
}
