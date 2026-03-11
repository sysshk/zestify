class AppUser {
  final String uid;
  final String name;
  final String email;
  final String? phone;
  final String provider; // 'google' | 'kakao' | 'naver'
  final String? profileImageUrl;
  final DateTime createdAt;

  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    required this.provider,
    this.profileImageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'provider': provider,
        'profileImageUrl': profileImageUrl,
        'createdAt': createdAt.toIso8601String(),
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        uid: json['uid'] as String,
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phone: json['phone'] as String?,
        provider: json['provider'] as String? ?? 'google',
        profileImageUrl: json['profileImageUrl'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : DateTime.now(),
      );
}
