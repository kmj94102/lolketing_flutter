
import 'package:lolketing_flutter/model/grade.dart';
import 'package:lolketing_flutter/util/common.dart';

class User {
  int index;
  String nickname;
  String id;
  String mobile;
  String address;
  int lolketingId;
  String grade;
  int point;
  int cash;
  int totalCoupons;
  int availableCoupons;
  List<Coupon> list;

  User({
    this.index = 0,
    this.nickname = '',
    this.id = '',
    this.mobile = '',
    this.address = '',
    this.lolketingId = 0,
    this.grade = '',
    this.point = 0,
    this.cash = 0,
    this.totalCoupons = 0,
    this.availableCoupons = 0,
    this.list = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var listFromJson = json['list'] as List;
    List<Coupon> couponList = listFromJson.map((i) => Coupon.fromJson(i)).toList();

    return User(
      index: json['index'],
      nickname: json['nickname'],
      id: json['id'],
      mobile: json['mobile'],
      address: json['address'],
      lolketingId: json['lolketingId'],
      grade: json['grade'],
      point: json['point'],
      cash: json['cash'],
      totalCoupons: json['totalCoupons'],
      availableCoupons: json['availableCoupons'],
      list: couponList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> listToJson = this.list.map((i) => i.toJson()).toList();

    return {
      'index': index,
      'nickname': nickname,
      'id': id,
      'mobile': mobile,
      'address': address,
      'lolketingId': lolketingId,
      'grade': grade,
      'point': point,
      'cash': cash,
      'totalCoupons': totalCoupons,
      'availableCoupons': availableCoupons,
      'list': listToJson,
    };
  }

  String getMobileFormat() {
      RegExp regExp7 = RegExp(r'(\d{3})(\d{3})(\d{4})');
      RegExp regExp8 = RegExp(r'(\d{3})(\d{4})(\d{4})');

      if (mobile.length == 10) {
        return mobile.replaceAllMapped(regExp7, (Match m) => '${m[1]}-${m[2]}-${m[3]}');
      } else if (mobile.length == 11) {
        return mobile.replaceAllMapped(regExp8, (Match m) => '${m[1]}-${m[2]}-${m[3]}');
      } else {
        return '전화 번호를 등록해 주세요';
      }
  }

  String getAddressFormat() {
    if(address.isEmpty) {
      return '주소를 등록해 주세요';
    } else {
      return address;
    }
  }

  String getMyCashFormat() {
    return priceFormatWon(cash);
  }

  String getCouponProgress() {
    return '$availableCoupons / $totalCoupons';
  }

  String getPointProgress() {
    return '$point / ${GradeExtension.getMaxPoint(grade)}';
  }

  double getProgress() {
    try {
      return point / GradeExtension.getMaxPoint(grade);
    } catch(e) {
      return 0.0;
    }
  }
}

class Coupon {
  int rp;
  String name;
  bool isUsed;
  int userId;
  int id;
  String number;
  String timestamp;

  Coupon({
    required this.rp,
    required this.name,
    required this.isUsed,
    required this.userId,
    required this.id,
    required this.number,
    required this.timestamp,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      rp: json['rp'],
      name: json['name'],
      isUsed: json['isUsed'],
      userId: json['user_id'],
      id: json['id'],
      number: json['number'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rp': rp,
      'name': name,
      'isUsed': isUsed,
      'user_id': userId,
      'id': id,
      'number': number,
      'timestamp': timestamp,
    };
  }
}
