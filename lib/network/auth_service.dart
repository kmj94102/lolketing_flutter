import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lolketing_flutter/model/login_model.dart';
import 'package:lolketing_flutter/util/common.dart';

class AuthService {
  Future<LoginResult> emailLogin(LoginInfo info) async {
    var url = '$baseUrl/user/login/email';
    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': info.id,
          'password': info.password,
        })
    );
    if(response.statusCode == 200) {
      return LoginResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return throw('login fail \n ${jsonDecode(utf8.decode(response.bodyBytes))['detail']}');
    }
  }
}