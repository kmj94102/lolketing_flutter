import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lolketing_flutter/model/address_model.dart';
import 'package:lolketing_flutter/model/login_model.dart';
import 'package:lolketing_flutter/model/user.dart';
import 'package:lolketing_flutter/util/common.dart';

import '../database/auth_database.dart';

class AuthService {
  /// 로그인
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

  /// 회원 가입
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

  /// 회원 탈퇴
  Future<void> withdrawal() async {
    const url = '$baseUrl/user/withdrawal';
    final id = await AuthDatabase().fetchUserId();

    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
        })
    );

    if(response.statusCode != 200) {
      throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  /// 주소 겁색
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

  /// 내 정보 조회
  Future<User> fetchMyInfo() async {
    const url = '$baseUrl/user/select/myInfo';
    final id = await AuthDatabase().fetchUserIndex();

    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
        })
    );

    if(response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  /// 캐시 충전
  Future<User> cashCharging(int cash) async {
    const url = '$baseUrl/user/update/charging';
    final id = await AuthDatabase().fetchUserIndex();

    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'cash': cash
        })
    );

    if(response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  /// 쿠폰 사용
  Future<User> usingCoupon(int couponId) async {
    const url = '$baseUrl/user/update/usingCoupon';
    final id = await AuthDatabase().fetchUserIndex();

    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'couponId': couponId
        })
    );

    if(response.statusCode == 200) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  /// 신규 유저 쿠폰 발급 여부 조회
  Future<bool> fetchNewUserCoupon() async {
    const url = '$baseUrl/user/select/newUserCoupon';
    final id = await AuthDatabase().fetchUserId();

    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
        })
    );

    if(response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  /// 신규 유저 쿠폰 발급
  Future<void> insertNewUserCoupon() async {
    const url = '$baseUrl/user/insert/newUserCoupon';
    final id = await AuthDatabase().fetchUserIndex();

    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
        })
    );

    if(response.statusCode != 200) {
      throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  /// 룰렛 횟수 조회
  Future<int> fetchRouletteCount() async {
    const url = '$baseUrl/user/select/roulette';
    final id = await AuthDatabase().fetchUserIndex();

    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
        })
    );

    if(response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['count'];
    } else {
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

  /// 룰렛 쿠폰 발급
  Future<int> insertRouletteCoupon(int rp) async {
    const url = '$baseUrl/user/insert/rouletteCoupon';
    final id = await AuthDatabase().fetchUserIndex();

    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'rp': rp
        })
    );

    if(response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))['count'];
    } else {
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }
}