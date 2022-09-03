class User {
  late final int id;
  late final String name;
  late final String password;

  User({required this.id, required this.name, required this.password});

  Map<String, dynamic> toMap() {
    return {'id': id,'name': name, 'password': password};
  }

  User.fromMap(Map<String, dynamic> result)
      : name = result['name'],
        password = result['password'];
}
