class UserX {
  int id;
  String nombres, apellidos, email;

  UserX(
      {required this.id,
      required this.nombres,
      required this.apellidos,
      required this.email});

  factory UserX.fromJson(Map<String, dynamic> data) {
    return UserX(
        id: data['id'],
        nombres: data['nombres'] ?? "",
        apellidos: data['apellidos'] ?? "",
        email: data['email'] ?? "");
  }
}
