class User {
  final String username;

  User(this.username);

  Map<String, dynamic> toJson() => {
        'username': username,
      };

  User.fromJson(Map<String, dynamic> json) : username = json['username'];
}
