import 'service_type.dart';

class Booking {
  final String? id;
  final String userId;
  final ServiceType serviceType;
  final String address;
  final String addressDetail;
  final String postalCode;
  final DateTime scheduledAt;
  final String sizeLabel;
  final int basePrice;
  final List<String> addons;
  final int addonPrice;
  final int totalPrice;
  final String customerName;
  final String customerPhone;
  final String paymentStatus; // 'pending' | 'paid' | 'cancelled'
  final String? portonePaymentId;
  final DateTime createdAt;

  const Booking({
    this.id,
    required this.userId,
    required this.serviceType,
    required this.address,
    required this.addressDetail,
    required this.postalCode,
    required this.scheduledAt,
    required this.sizeLabel,
    required this.basePrice,
    required this.addons,
    required this.addonPrice,
    required this.totalPrice,
    required this.customerName,
    required this.customerPhone,
    required this.paymentStatus,
    this.portonePaymentId,
    required this.createdAt,
  });

  Booking copyWith({
    String? id,
    String? paymentStatus,
    String? portonePaymentId,
  }) {
    return Booking(
      id: id ?? this.id,
      userId: userId,
      serviceType: serviceType,
      address: address,
      addressDetail: addressDetail,
      postalCode: postalCode,
      scheduledAt: scheduledAt,
      sizeLabel: sizeLabel,
      basePrice: basePrice,
      addons: addons,
      addonPrice: addonPrice,
      totalPrice: totalPrice,
      customerName: customerName,
      customerPhone: customerPhone,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      portonePaymentId: portonePaymentId ?? this.portonePaymentId,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'serviceType': serviceType.routeParam,
        'address': address,
        'addressDetail': addressDetail,
        'postalCode': postalCode,
        'scheduledAt': scheduledAt.toIso8601String(),
        'sizeLabel': sizeLabel,
        'basePrice': basePrice,
        'addons': addons,
        'addonPrice': addonPrice,
        'totalPrice': totalPrice,
        'customerName': customerName,
        'customerPhone': customerPhone,
        'paymentStatus': paymentStatus,
        'portonePaymentId': portonePaymentId,
        'createdAt': createdAt.toIso8601String(),
      };
}
