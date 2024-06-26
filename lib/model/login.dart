class LoginInfo {
  String id;
  String password;

  LoginInfo({this.id = '', this.password = ''});

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(id: json['id'], password: json['password']);
  }
}

class LoginResult {
  final int idx;
  final int id;
  final String email;
  final String nickname;

  const LoginResult(
      {this.idx = 0, this.id = 0, this.email = '', this.nickname = ''});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
        id: json['id'],
        email: json['email'],
        nickname: json['nickname']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nickname': nickname,
    };
  }
}
