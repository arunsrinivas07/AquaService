// lib/core/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── LoginAuth ──────────────────────────────────────────────────────────
  Future<Map<String, dynamic>?> getLoginAuth(String phone) async {
    final phoneNum = int.tryParse(phone);
    final snap = await _db
        .collection('LoginAuth')
        .where('PhoneNumber', isEqualTo: phoneNum ?? phone)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return snap.docs.first.data();
  }

  // ── CustomerDetails ────────────────────────────────────────────────────
  Future<Map<String, dynamic>?> getCustomerByPhone(String phone) async {
    final phoneNum = int.tryParse(phone);

    // Try all possible field name / type combos
    final fieldNames = ['PhoneNumber', 'Phone Number', 'phoneNumber', 'phone'];
    final values = <dynamic>[if (phoneNum != null) phoneNum, phone];

    for (final field in fieldNames) {
      for (final val in values) {
        final snap = await _db
            .collection('CustomerDetails')
            .where(field, isEqualTo: val)
            .limit(1)
            .get();
        if (snap.docs.isNotEmpty) {
          final data = snap.docs.first.data();
          data['docId'] = snap.docs.first.id;
          debugPrint('CustomerDetails FOUND with field=$field, val=$val');
          debugPrint('CustomerDetails fields: ${data.keys.toList()}');
          return data;
        }
      }
    }

    // Fallback: grab first doc and log its fields for debugging
    final allDocs = await _db.collection('CustomerDetails').limit(1).get();
    if (allDocs.docs.isNotEmpty) {
      final doc = allDocs.docs.first;
      debugPrint('CustomerDetails doc ${doc.id} fields: ${doc.data().keys.toList()}');
      debugPrint('CustomerDetails doc data: ${doc.data()}');
      // Return it anyway so user sees something
      final data = doc.data();
      data['docId'] = doc.id;
      return data;
    }

    debugPrint('CustomerDetails collection is empty!');
    return null;
  }

  Future<void> updateCustomerProfile(String docId, Map<String, dynamic> data) async {
    await _db.collection('CustomerDetails').doc(docId).update(data);
  }

  Future<void> updatePreviousMaintenanceDate(String docId, DateTime date) async {
    await _db.collection('CustomerDetails').doc(docId).update({
      'previous_maintenance_date': Timestamp.fromDate(date),
    });
  }

  Future<void> updateNextMaintenanceDate(String docId, DateTime date) async {
    await _db.collection('CustomerDetails').doc(docId).update({
      'next_maintenance_date': Timestamp.fromDate(date),
    });
  }

  Future<void> updateCustomerPassword(String phone, String newPassword) async {
    final phoneNum = int.tryParse(phone);
    final snap = await _db
        .collection('LoginAuth')
        .where('PhoneNumber', isEqualTo: phoneNum ?? phone)
        .limit(1)
        .get();
    
    if (snap.docs.isNotEmpty) {
      await _db.collection('LoginAuth').doc(snap.docs.first.id).update({
        'Password': newPassword,
      });
    }
  }

  // ── Payments ───────────────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getPaymentsByPhone(String phone) async {
    final phoneNum = int.tryParse(phone);
    var snap = await _db
        .collection('Payments')
        .where('PhoneNumber', isEqualTo: phoneNum ?? phone)
        .get();

    if (snap.docs.isEmpty) {
      snap = await _db
          .collection('Payments')
          .where('PhoneNumber', isEqualTo: phone)
          .get();
    }

    return snap.docs.map((d) {
      final data = d.data();
      data['docId'] = d.id;
      return data;
    }).toList();
  }

  // ── Maintenance & Installation ─────────────────────────────────────────
  /// Fetches all maintenance/installation records for a phone number.
  Future<List<Map<String, dynamic>>> getMaintenanceByPhone(String phone) async {
    final phoneNum = int.tryParse(phone);
    final snap = await _db
        .collection('maintance_Installation')
        .where('PhoneNumber', isEqualTo: phoneNum ?? phone)
        .get();

    return snap.docs.map((d) {
      final data = d.data();
      data['docId'] = d.id;
      return data;
    }).toList();
  }

  /// Saves a new maintenance/installation booking.
  Future<void> addMaintenanceBooking({
    required String phone,
    required DateTime dateTime,
    required String machineModel,
    required String serviceType,
    String? address,
  }) async {
    final phoneNum = int.tryParse(phone);
    await _db.collection('maintance_Installation').add({
      'PhoneNumber': phoneNum ?? phone,
      'date_time': Timestamp.fromDate(dateTime),
      'machine Model': machineModel,
      'service_type': serviceType,
      'address': address ?? '',
      'status': 'pending',
    });
  }

  // ── Complaints ─────────────────────────────────────────────────────────
  Future<List<Map<String, dynamic>>> getComplaintsByPhone(String phone) async {
    final phoneNum = int.tryParse(phone);
    final snap = await _db
        .collection('Complaints')
        .where('PhoneNumber', isEqualTo: phoneNum ?? phone)
        .get();

    return snap.docs.map((d) {
      final data = d.data();
      data['docId'] = d.id;
      return data;
    }).toList();
  }

  // ── Cancellations ──────────────────────────────────────────────────────
  Future<void> cancelRequest(String collection, String docId) async {
    await _db.collection(collection).doc(docId).update({
      'status': 'cancelled',
    });
  }
}
