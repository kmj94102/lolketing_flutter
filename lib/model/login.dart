class LoginInfo {
  final String id;
  final String password;

  const LoginInfo({this.id = '', this.password = ''});

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(id: json['id'], password: json['password']);
  }
}

class LoginResult {
  final int index;
  final int id;
  final String email;
  final String nickname;

  const LoginResult(
      {this.index = 0, this.id = 0, this.email = '', this.nickname = ''});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
        id: json['id'],
        email: json['email'],
        nickname: json['nickname']);
  }
}
