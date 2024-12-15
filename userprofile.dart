// import 'package:flutter/material.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProfileScreen extends StatelessWidget {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//
//   Future<Map<String, dynamic>> fetchUserData() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       DocumentSnapshot snapshot =
//       await _firestore.collection('users').doc(user.uid).get();
//       return snapshot.data() as Map<String, dynamic>;
//     }
//     throw "User not logged in";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchUserData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }
//
//           final userData = snapshot.data!;
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Name: ${userData['name']}"),
//                 Text("Email: ${userData['email']}"),
//                 Text("Mobile: ${userData['mobile']}"),
//                 Text("Address: ${userData['address']}"),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
      await _firestore.collection('users').doc(user.uid).get();
      return snapshot.data() as Map<String, dynamic>;
    }
    throw "User not logged in";
  }

  Stream<QuerySnapshot> fetchUserOrders() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .orderBy('timestamp', descending: true)
          .snapshots();
    }
    throw "User not logged in";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final userData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${userData['name']}"),
                Text("Email: ${userData['email']}"),
                Text("Mobile: ${userData['mobile']}"),
                Text("Address: ${userData['address']}"),
                SizedBox(height: 20),
                Text(
                  "Your Orders",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: fetchUserOrders(),
                    builder: (context, orderSnapshot) {
                      if (orderSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (orderSnapshot.hasError) {
                        return Center(child: Text("Error: ${orderSnapshot.error}"));
                      }

                      final orders = orderSnapshot.data!.docs;
                      if (orders.isEmpty) {
                        return Center(child: Text("No orders placed yet."));
                      }

                      return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final orderData = orders[index].data() as Map<String, dynamic>;
                          final items = (orderData['items'] as List)
                              .map((item) => item as Map<String, dynamic>)
                              .toList();

                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text("Order Total: Rs. ${orderData['total']}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: items.map((item) {
                                  return Text("${item['name']} (x${item['quantity']})");
                                }).toList(),
                              ),
                              trailing: Text("Date: ${DateTime.fromMillisecondsSinceEpoch(orderData['timestamp'].seconds * 1000)}"),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

