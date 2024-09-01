enum Language {
  englist('en_US', 'us'),
  simplifiedChinese('zh_CN', 'zh'),
  translateChinese('zh_Hant', 'tw'),
  ;

  const Language(this.isoCode, this.mdvrCode);

  final String isoCode;
  final String mdvrCode;

  static Language fromIsoCode(String code) {
    return Language.values
        .firstWhere((e) => e.isoCode == code, orElse: () => Language.englist);
  }

  static Language fromMdvrCode(String code) {
    return Language.values
        .firstWhere((e) => e.mdvrCode == code, orElse: () => Language.englist);
  }
}
