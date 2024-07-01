/// confmKey : (필수) 신청시 발급받은 승인키
/// currentPage : (필수) 현재 페이지 번호, 기본 값 1
/// countPerPage : (필수) 페이지당 출력할 결과 Row 수, 기본 값 10
/// keyword : (필수) 주소 검색어
/// resultType : 검색결과형식 설정(xml, json), 기본 값 xml
/// hstryYn : [2020년12월8일 추가된 항목] 변동된 주소정보 포함 여부, 기본 값 N
/// firstSort : [2020년12월8일 추가된 항목] 정확도순 정렬(none)
///             우선정렬(road: 도로명 포함, location: 지번 포함), 기본 값 none
///             ※ keyword(검색어)가 우선정렬 항목에 포함된 결과 우선 표출
/// addInfoYn : [2020년12월8일 추가된 항목]
///             출력결과에 추가된 항목(hstryYn, relJibun, hemdNm) 제공여부, 기본 값 N
///             ※ 해당 옵션으로 추가제공되는 항목의 경우, 추후 특정항목이 제거되거나 추가될 수 있으니 적용 시 고려해주시기 바랍니다.
class AddressParam {
  String confmKey;
  int currentPage;
  int countPerPage;
  String keyword;
  String resultType;

  AddressParam({required this.confmKey,
    required this.currentPage,
    this.countPerPage = 20,
    required this.keyword,
    this.resultType = 'json'});

  Map<String, dynamic> toJson() {
    return {
      'confmKey': confmKey,
      'currentPage': currentPage.toString(),
      'countPerPage': countPerPage.toString(),
      'keyword': keyword,
      'resultType': resultType,
    };
  }
}

class AddressCommon {
  final String errorMessage;
  final String countPerPage;
  final String totalCount;
  final String errorCode;
  final String currentPage;

  AddressCommon({
    required this.errorMessage,
    required this.countPerPage,
    required this.totalCount,
    required this.errorCode,
    required this.currentPage,
  });

  factory AddressCommon.fromJson(Map<String, dynamic> json) {
    return AddressCommon(
      errorMessage: json['errorMessage'],
      countPerPage: json['countPerPage'],
      totalCount: json['totalCount'],
      errorCode: json['errorCode'],
      currentPage: json['currentPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errorMessage': errorMessage,
      'countPerPage': countPerPage,
      'totalCount': totalCount,
      'errorCode': errorCode,
      'currentPage': currentPage,
    };
  }
}

class Juso {
  final String detBdNmList;
  final String engAddr;
  final String rn;
  final String emdNm;
  final String zipNo;
  final String roadAddrPart2;
  final String emdNo;
  final String sggNm;
  final String jibunAddr;
  final String siNm;
  final String roadAddrPart1;
  final String bdNm;
  final String admCd;
  final String udrtYn;
  final String lnbrMnnm;
  final String roadAddr;
  final String lnbrSlno;
  final String buldMnnm;
  final String bdKdcd;
  final String liNm;
  final String rnMgtSn;
  final String mtYn;
  final String bdMgtSn;
  final String buldSlno;

  Juso({
    required this.detBdNmList,
    required this.engAddr,
    required this.rn,
    required this.emdNm,
    required this.zipNo,
    required this.roadAddrPart2,
    required this.emdNo,
    required this.sggNm,
    required this.jibunAddr,
    required this.siNm,
    required this.roadAddrPart1,
    required this.bdNm,
    required this.admCd,
    required this.udrtYn,
    required this.lnbrMnnm,
    required this.roadAddr,
    required this.lnbrSlno,
    required this.buldMnnm,
    required this.bdKdcd,
    required this.liNm,
    required this.rnMgtSn,
    required this.mtYn,
    required this.bdMgtSn,
    required this.buldSlno,
  });

  factory Juso.fromJson(Map<String, dynamic> json) {
    return Juso(
      detBdNmList: json['detBdNmList'] ?? "",
      engAddr: json['engAddr'],
      rn: json['rn'],
      emdNm: json['emdNm'],
      zipNo: json['zipNo'],
      roadAddrPart2: json['roadAddrPart2'] ?? "",
      emdNo: json['emdNo'],
      sggNm: json['sggNm'],
      jibunAddr: json['jibunAddr'],
      siNm: json['siNm'],
      roadAddrPart1: json['roadAddrPart1'],
      bdNm: json['bdNm'],
      admCd: json['admCd'],
      udrtYn: json['udrtYn'],
      lnbrMnnm: json['lnbrMnnm'],
      roadAddr: json['roadAddr'],
      lnbrSlno: json['lnbrSlno'],
      buldMnnm: json['buldMnnm'],
      bdKdcd: json['bdKdcd'],
      liNm: json['liNm'] ?? "",
      rnMgtSn: json['rnMgtSn'],
      mtYn: json['mtYn'],
      bdMgtSn: json['bdMgtSn'],
      buldSlno: json['buldSlno'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'detBdNmList': detBdNmList,
      'engAddr': engAddr,
      'rn': rn,
      'emdNm': emdNm,
      'zipNo': zipNo,
      'roadAddrPart2': roadAddrPart2,
      'emdNo': emdNo,
      'sggNm': sggNm,
      'jibunAddr': jibunAddr,
      'siNm': siNm,
      'roadAddrPart1': roadAddrPart1,
      'bdNm': bdNm,
      'admCd': admCd,
      'udrtYn': udrtYn,
      'lnbrMnnm': lnbrMnnm,
      'roadAddr': roadAddr,
      'lnbrSlno': lnbrSlno,
      'buldMnnm': buldMnnm,
      'bdKdcd': bdKdcd,
      'liNm': liNm,
      'rnMgtSn': rnMgtSn,
      'mtYn': mtYn,
      'bdMgtSn': bdMgtSn,
      'buldSlno': buldSlno,
    };
  }
}

class Results {
  final AddressCommon common;
  final List<Juso> juso;

  Results({required this.common, required this.juso});

  factory Results.fromJson(Map<String, dynamic> json) {
    var jusoList = json['juso'] as List;
    List<Juso> jusoItems = jusoList.map((juso) => Juso.fromJson(juso)).toList();

    return Results(
      common: AddressCommon.fromJson(json['common']),
      juso: jusoItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'common': common.toJson(),
      'juso': juso.map((juso) => juso.toJson()).toList(),
    };
  }
}

class AddressResponse {
  final Results results;

  AddressResponse({required this.results});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      results: Results.fromJson(json['results']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.toJson(),
    };
  }

  AddressResult mapper() {
    final totalCount = int.parse(results.common.totalCount);
    final currentSize = int.parse(results.common.countPerPage) * int.parse(results.common.currentPage);
    final list = results.juso.map((e) => e.roadAddr).toList();

    return AddressResult(list: list, isMoreData: totalCount > currentSize);
  }
}

class AddressResult {
  final List<String> list;
  final bool isMoreData;

  AddressResult({
    required this.list,
    required this.isMoreData
  });
}