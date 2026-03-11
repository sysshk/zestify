enum ServiceType {
  living,
  moving;

  static ServiceType fromString(String s) {
    return s == 'moving' ? ServiceType.moving : ServiceType.living;
  }

  String get displayName => this == living ? '생활청소' : '이사청소';
  String get routeParam => name;

  String get description => this == living
      ? '일상적인 집 청소부터 대청소까지\n전문 청소사가 깔끔하게 해결해 드립니다'
      : '이사 전·후 새 집처럼 깨끗하게\n입주 청소 전문 서비스';
}
