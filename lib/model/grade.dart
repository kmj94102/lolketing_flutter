enum Grade {
  bronze,
  silver,
  gold,
  platinum,
  master,
}

extension GradeExtension on Grade {
  String get koreanName {
    switch (this) {
      case Grade.bronze:
        return "브론즈";
      case Grade.silver:
        return "실버";
      case Grade.gold:
        return "골드";
      case Grade.platinum:
        return "플래티넘";
      case Grade.master:
        return "마스터";
      default:
        return "브론즈";
    }
  }

  String get code {
    switch (this) {
      case Grade.bronze:
        return "USER001";
      case Grade.silver:
        return "USER002";
      case Grade.gold:
        return "USER003";
      case Grade.platinum:
        return "USER004";
      case Grade.master:
        return "USER005";
      default:
        return "USER001";
    }
  }

  int get maxPoint {
    switch (this) {
      case Grade.bronze:
        return 3000;
      case Grade.silver:
        return 30000;
      case Grade.gold:
        return 300000;
      case Grade.platinum:
        return 300000;
      case Grade.master:
        return 300000;
      default:
        return 3000;
    }
  }

  String get image {
    switch (this) {
      case Grade.bronze:
        return "https://firebasestorage.googleapis.com/v0/b/lolketing.appspot.com/o/bronze.png?alt=media&token=0f60a4c2-a58f-4fd9-9546-b9d6f7bdfdd2";
      case Grade.silver:
        return "https://firebasestorage.googleapis.com/v0/b/lolketing.appspot.com/o/silver.png?alt=media&token=89072c89-30f4-49ee-9114-768450109c9e";
      case Grade.gold:
        return "https://firebasestorage.googleapis.com/v0/b/lolketing.appspot.com/o/gold.png?alt=media&token=dc94d6d4-633d-46e5-9833-a1195da7d4e0";
      case Grade.platinum:
        return "https://firebasestorage.googleapis.com/v0/b/lolketing.appspot.com/o/platinum.png?alt=media&token=55428f81-1907-414f-9eea-80cce2087d42";
      case Grade.master:
        return "https://firebasestorage.googleapis.com/v0/b/lolketing.appspot.com/o/master.png?alt=media&token=60ba025c-4357-4017-912c-94788f3c4e7e";
      default:
        return "https://firebasestorage.googleapis.com/v0/b/lolketing.appspot.com/o/bronze.png?alt=media&token=0f60a4c2-a58f-4fd9-9546-b9d6f7bdfdd2";
    }
  }

  static Grade getGrade(String code) {
    return Grade.values.firstWhere((grade) => grade.code == code, orElse: () => Grade.bronze);
  }

  static String getImage(String code) {
    return getGrade(code).image;
  }

  static int getMaxPoint(String code) {
    return getGrade(code).maxPoint;
  }

  static String getKoreanName(String code) {
    return getGrade(code).koreanName;
  }

  static String getNextGrade(String code, int point) {
    if (code == Grade.platinum.code || code == Grade.master.code) {
      return "";
    } else if (point < Grade.silver.maxPoint) {
      return Grade.silver.code;
    } else if (point < Grade.gold.maxPoint) {
      return Grade.gold.code;
    } else {
      return Grade.platinum.code;
    }
  }
}
