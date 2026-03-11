import 'service_type.dart';

class PricingOption {
  final String label;
  final int basePrice;

  const PricingOption({required this.label, required this.basePrice});
}

class AddonOption {
  final String label;
  final int price;

  const AddonOption({required this.label, required this.price});
}

class PricingTable {
  PricingTable._();

  static const living = [
    PricingOption(label: '10평 이하', basePrice: 80000),
    PricingOption(label: '10~20평', basePrice: 100000),
    PricingOption(label: '20~30평', basePrice: 130000),
    PricingOption(label: '30~40평', basePrice: 160000),
    PricingOption(label: '40평 이상', basePrice: 190000),
  ];

  static const moving = [
    PricingOption(label: '10평 이하', basePrice: 120000),
    PricingOption(label: '10~20평', basePrice: 160000),
    PricingOption(label: '20~30평', basePrice: 200000),
    PricingOption(label: '30~40평', basePrice: 240000),
    PricingOption(label: '40평 이상', basePrice: 280000),
  ];

  static const addons = [
    AddonOption(label: '냉장고 내부 청소', price: 15000),
    AddonOption(label: '전자레인지 내부', price: 10000),
    AddonOption(label: '세탁기 내부 청소', price: 20000),
    AddonOption(label: '에어컨 필터 청소', price: 15000),
  ];

  static List<PricingOption> forService(ServiceType type) {
    return type == ServiceType.living ? living : moving;
  }
}
