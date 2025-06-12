class UserModel {
  final String id;
  final String name;
  final String email;
  final String token; // تأكدي أن token لا يقبل null

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '', // إذا كانت null نستبدلها بـ ''
    );
  }

  get phone => null;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "token": token,
    };
  }
}
