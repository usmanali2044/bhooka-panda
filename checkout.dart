// import 'package:flutter/material.dart';
// import 'package:flutter_project_1/cart.dart';
//
// class CheckoutPage extends StatelessWidget {
//   final List<CartItem> cartItems;
//
//   CheckoutPage({required this.cartItems});
//
//   @override
//   Widget build(BuildContext context) {
//     double total = cartItems.fold(
//       0,
//           (sum, item) => sum + (item.quantity * double.parse(item.price.split(' ')[1])),
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//         backgroundColor: Color(0xFFEA2A00),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return ListTile(
//                   leading: Image.asset(item.image, width: 50),
//                   title: Text(item.name),
//                   subtitle: Text('Qty: ${item.quantity}'),
//                   trailing: Text(item.price),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total: Rs. $total',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Implement order placement logic
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text('Order Placed'),
//                         content: Text('Your order has been successfully placed!'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFEA2A00),
//                   ),
//                   child: Text('Place Order',style: TextStyle(color: Colors.black),),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_project_1/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutPage extends StatelessWidget {
  final List<CartItem> cartItems;

  CheckoutPage({required this.cartItems});

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void placeOrder(BuildContext context) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Prepare order details
        List<Map<String, dynamic>> orderItems = cartItems.map((item) {
          return {
            'name': item.name,
            'quantity': item.quantity,
            'price': item.price,
            'image': item.image,
          };
        }).toList();

        double total = cartItems.fold(
          0,
              (sum, item) => sum + (item.quantity * double.parse(item.price.split(' ')[1])),
        );

        // Save order in Firestore under the user's document
        await _firestore.collection('users').doc(user.uid).collection('orders').add({
          'items': orderItems,
          'total': total,
          'timestamp': FieldValue.serverTimestamp(),
        });

        cartItems.clear();

        // Show confirmation dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Order Placed'),
            content: Text('Your order has been successfully placed!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Go back to the previous page
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        throw "User not logged in.";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error placing order: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(
      0,
          (sum, item) => sum + (item.quantity * double.parse(item.price.split(' ')[1])),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Color(0xFFEA2A00),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.asset(item.image, width: 50),
                  title: Text(item.name),
                  subtitle: Text('Qty: ${item.quantity}'),
                  trailing: Text(item.price),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: Rs. $total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => placeOrder(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEA2A00),
                  ),
                  child: Text(
                    'Place Order',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}

