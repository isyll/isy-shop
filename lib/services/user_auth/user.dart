class User {
  String? email;
  String? password;
  String? name;

  User({this.email, this.password});

  @override
  String toString() => 'User(email=$email, password=$password, name=$name)';
}
