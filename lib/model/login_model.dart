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
        id: json['id'], email: json['email'], nickname: json['nickname']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nickname': nickname,
    };
  }
}

class JoinInfo {
  String type;
  String id;
  String password;
  String passwordCheck;
  String nickname;
  String gender;
  String birthday;
  String birthYear;
  String mobile;
  String address;

  JoinInfo({
    required this.type,
    this.id = '',
    this.password = '',
    this.passwordCheck = '',
    this.nickname = '',
    this.gender = '',
    this.birthday = '',
    this.birthYear = '',
    this.mobile = '',
    this.address = '',
  });

  factory JoinInfo.fromJson(Map<String, dynamic> json) {
    return JoinInfo(
      type: json['type'],
      id: json['id'],
      password: json['password'],
      passwordCheck: json['passwordCheck'],
      nickname: json['nickname'],
      gender: json['gender'],
      birthday: json['birthday'],
      birthYear: json['birthYear'],
      mobile: json['mobile'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
      'password': password,
      'passwordCheck': passwordCheck,
      'nickname': nickname,
      'gender': gender,
      'birthday': birthday,
      'birthYear': birthYear,
      'mobile': mobile,
      'address': address,
    };
  }

  bool checkValidation() {
    if(isValidEmail()) {
      return throw ('아이디는 이메일 형식으로 입력해 주세요.');
    }
    if(id.length > 100) {
      return throw ('아이디는 100자 이하로 설정해주세요.');
    }
    if(isEmailType() && !isPasswordValid()) {
      return throw ('비밀번호는 영문, 숫자, 특수문자가 모두 포함되게 입력해 주세요.');
    }
    if(isEmailType() && isPasswordLengthCheck()) {
      return throw ('비밀번호는 6자 이상 30자 이하로 입력해 주세요.');
    }
    if(isEmailType() && password != passwordCheck) {
      return throw ('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
    }
    if(nickname.isEmpty || nickname.length >= 11) {
      return throw ('닉네임은 1~11자 이상으로 입력해 주세요.');
    }
    if(mobile.isNotEmpty && isMobileLengthCheck()) {
      return throw ('전화번호를 확인해 주세요.');
    }
    return true;
  }

  bool isEmailType() {
    return type == 'email';
  }

  bool isValidEmail() {
    final RegExp regex = RegExp(
        r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$'
    );
    return !regex.hasMatch(id);
  }

  bool isPasswordValid() {
    final RegExp regex = RegExp(
        r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()]).{3,30}$'
    );
    return regex.hasMatch(password);
  }

  bool isPasswordLengthCheck() {
    return password.length < 6 || password.length > 30;
  }

  bool isMobileLengthCheck() {
    return mobile.length < 10 || mobile.length > 11;
  }

}
