import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lolketing_flutter/model/address_model.dart';
import 'package:lolketing_flutter/model/login_model.dart';
import 'package:lolketing_flutter/model/user.dart';
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
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  Future join(JoinInfo info) async {
    info.checkValidation();

    var url = '$baseUrl/user/join/email';
    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(info.toJson())
    );
    if(response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  Future<AddressResult> searchAddress(String value) async {
    await dotenv.load();
    String apiKey = dotenv.get("ADDRESS_API_KEY");
    final queryParameters = AddressParam(confmKey: apiKey, currentPage: 1, keyword: value).toJson();
    final uri = Uri.https('www.juso.go.kr', '/addrlink/addrLinkApi.do', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return AddressResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes))).mapper();
    } else {
      return throw('result \n ${jsonDecode(utf8.decode(response.bodyBytes))['detail']}');
    }
  }

  Future<User> fetchMyInfo() async {
    const url = '$baseUrl/user/select/myInfo';
    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': '9',
        })
    );

    if(response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }
}