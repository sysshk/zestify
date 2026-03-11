import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking.dart';

class FirestoreService {
  FirestoreService._();

  static final _db = FirebaseFirestore.instance;

  static Future<String> saveBooking(Booking booking) async {
    final ref = await _db.collection('bookings').add(booking.toJson());
    return ref.id;
  }

  static Future<List<Map<String, dynamic>>> getBookingsByPhone(
    String phone,
  ) async {
    final snapshot = await _db
        .collection('bookings')
        .where('customerPhone', isEqualTo: phone)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((d) => {'id': d.id, ...d.data()})
        .toList();
  }
}
