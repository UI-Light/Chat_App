class AppUser {
  final String id;
  final String displayName;
  final String email;
  final String? photoURL;

  AppUser({
    required this.id,
    required this.displayName,
    required this.email,
    this.photoURL,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? "",
      displayName: json["username"] ?? "",
      email: json['email'] ?? "",
      photoURL: json['photoURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": displayName,
      "email": email,
      "photoURL": photoURL,
    };
  }
}
