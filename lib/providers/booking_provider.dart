import 'package:flutter/foundation.dart';
import '../models/service_type.dart';
import '../models/pricing_option.dart';
import '../models/time_slot.dart';
import '../models/booking.dart';

class BookingProvider extends ChangeNotifier {
  // 서비스 타입
  ServiceType serviceType = ServiceType.living;

  // Step 진행
  int currentStep = 0;

  // Step 1 - 주소
  String address = '';
  String addressDetail = '';
  String postalCode = '';

  // Step 2 - 날짜/시간
  DateTime? selectedDate;
  TimeSlot? selectedTimeSlot;

  // Step 3 - 옵션
  PricingOption? selectedSize;
  final List<String> selectedAddons = [];

  // Step 4 - 고객 정보
  String customerName = '';
  String customerPhone = '';

  int get addonTotal {
    int total = 0;
    for (final addon in PricingTable.addons) {
      if (selectedAddons.contains(addon.label)) {
        total += addon.price;
      }
    }
    return total;
  }

  int get totalPrice => (selectedSize?.basePrice ?? 0) + addonTotal;

  bool get step1Valid =>
      address.isNotEmpty && addressDetail.isNotEmpty && postalCode.isNotEmpty;

  bool get step2Valid => selectedDate != null && selectedTimeSlot != null;

  bool get step3Valid => selectedSize != null;

  bool get step4Valid =>
      customerName.isNotEmpty &&
      customerPhone.isNotEmpty &&
      RegExp(r'^\d{10,11}$').hasMatch(customerPhone);

  void setServiceType(ServiceType type) {
    serviceType = type;
    selectedSize = null;
    selectedAddons.clear();
    notifyListeners();
  }

  void setAddress(String addr, String detail, String postal) {
    address = addr;
    addressDetail = detail;
    postalCode = postal;
    notifyListeners();
  }

  void setAddressDetail(String detail) {
    addressDetail = detail;
    notifyListeners();
  }

  void setDateTime(DateTime date, TimeSlot slot) {
    selectedDate = date;
    selectedTimeSlot = slot;
    notifyListeners();
  }

  void setSizeOption(PricingOption option) {
    selectedSize = option;
    notifyListeners();
  }

  void toggleAddon(String addonLabel) {
    if (selectedAddons.contains(addonLabel)) {
      selectedAddons.remove(addonLabel);
    } else {
      selectedAddons.add(addonLabel);
    }
    notifyListeners();
  }

  void setCustomerInfo(String name, String phone) {
    customerName = name;
    customerPhone = phone;
    notifyListeners();
  }

  void nextStep() {
    if (currentStep < 4) {
      currentStep++;
      notifyListeners();
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  Booking toBooking({required String userId}) {
    final date = selectedDate!;
    final hour = selectedTimeSlot!.hour;
    final scheduledAt = DateTime(date.year, date.month, date.day, hour);

    return Booking(
      userId: userId,
      serviceType: serviceType,
      address: address,
      addressDetail: addressDetail,
      postalCode: postalCode,
      scheduledAt: scheduledAt,
      sizeLabel: selectedSize!.label,
      basePrice: selectedSize!.basePrice,
      addons: List.from(selectedAddons),
      addonPrice: addonTotal,
      totalPrice: totalPrice,
      customerName: customerName,
      customerPhone: customerPhone,
      paymentStatus: 'pending',
      createdAt: DateTime.now(),
    );
  }

  void reset() {
    currentStep = 0;
    address = '';
    addressDetail = '';
    postalCode = '';
    selectedDate = null;
    selectedTimeSlot = null;
    selectedSize = null;
    selectedAddons.clear();
    customerName = '';
    customerPhone = '';
    notifyListeners();
  }
}
