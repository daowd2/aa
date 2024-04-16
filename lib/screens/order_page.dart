import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // استيراد حزمة Firebase Firestore

class OrderBox extends StatelessWidget {
  final String customerNumber;
  final String customerLocation;
  final double orderPrice;

  const OrderBox({
    Key? key,
    required this.customerNumber,
    required this.customerLocation,
    required this.orderPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Number: $customerNumber',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Customer Location: $customerLocation',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Order Price: $orderPrice',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // إضافة الطلب إلى Firebase Firestore عند النقر على الزر
              addDocument();
            },
            child: const Text('Add Order'), // نص الزر
          ),
        ],
      ),
    );
  }

  // وظيفة لإضافة البيانات إلى Firebase Firestore
  Future<void> addDocument() {
    CollectionReference orders = FirebaseFirestore.instance.collection('orders');

    // بيانات الطلب
    Map<String, dynamic> data = {
      'customerNumber': customerNumber,
      'customerLocation': customerLocation,
      'orderPrice': orderPrice,
    };

    // إضافة البيانات إلى Firestore
    return orders
        .add(data)
        // ignore: avoid_print
        .then((value) => print("Document Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add document: $error"));
  }
}
