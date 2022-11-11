import 'package:cloud_firestore/cloud_firestore.dart';

class TempData {
  int? id;
  String? name;
  String? company;
  String? from;
  int? amount;

  TempData({
    this.id,
    this.name,
    this.company,
    this.from,
    this.amount,
  });

  factory TempData.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final data = snapshot.data();
    return TempData(
      id: data['id'],
      name: data['name'],
      company: data['company'],
      from: data['from'],
      amount: data['amount'],
    );
  }

  updateAmount(value) {
    amount = value;
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (company != null) "company": company,
      if (from != null) "from": from,
      if (amount != null) "amount": amount,
    };
  }
}