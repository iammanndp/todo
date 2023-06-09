class Logup {
  final int? id;
  final String? username;
  final String email;
  final String password;

  const Logup({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
