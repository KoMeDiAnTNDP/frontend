class User {
  const User({
    required this.id,
    this.email
  });

  final String id;
  final String? email;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
}