class User {
  const User({
    required this.id,
    this.email,
    this.connectionTime,
  });

  final String id;
  final String? email;
  final DateTime? connectionTime;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      connectionTime: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'email': this.email,
    };
  }

  User copyWith({
    String? id,
    String? email,
    DateTime? connectionTime
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      connectionTime: connectionTime ?? this.connectionTime
    );
  }

  @override
  String toString() {
    return 'User('
        'id: ${this.id}, '
        'email: ${this.email})';
  }
}
