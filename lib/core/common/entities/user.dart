class User {

  final String id;
  final String name;
  final String email;

  User(this.id, this.name, this.email);

  @override
  String toString() {
    return '$id, $name, $email';
  }
}
