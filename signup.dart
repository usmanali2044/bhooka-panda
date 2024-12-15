import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_1/login.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  Future<void> _registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String mobile = mobileController.text.trim();
    String address = addressController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      _showSnackbar("Passwords do not match");
      return;
    }

    if (name.isEmpty || email.isEmpty || mobile.isEmpty || address.isEmpty || password.isEmpty) {
      _showSnackbar("All fields are required");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Register user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'mobile': mobile,
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _showSnackbar("Registration successful!");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Loginpage()));
    } catch (e) {
      _showSnackbar("Error: ${e.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDDF),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                "SignUp",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'FontMain',
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Add your Signup Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildTextField(nameController, 'Name'),
              _buildTextField(emailController, 'Email'),
              _buildTextField(mobileController, 'Mobile No.'),
              _buildTextField(addressController, 'Address'),
              _buildTextField(passwordController, 'Password', obscureText: true),
              _buildTextField(confirmPasswordController, 'Confirm Password', obscureText: true),
              SizedBox(height: 15),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEA2A00),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account ",
                        style: TextStyle(color: Colors.black, fontFamily: 'FontMain')),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => Loginpage()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color(0xFFEA2A00),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}



//
// import 'package:flutter/material.dart';
// import 'package:flutter_project_1/login.dart';
//
// class SignupPage extends StatefulWidget {
//
//   const SignupPage({super.key});
//
//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }
//
// class _SignupPageState extends State<SignupPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFFDDF),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//
//               SizedBox(height: 40,),
//                Text(
//                 "SignUp",
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontFamily: 'FontMain',
//                 ),
//               ),
//               SizedBox(height:10),
//               Text("Add your Signup Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold  ),),
//               SizedBox(height:10),
//               _buildTextField(nameController, 'Name',),
//               _buildTextField(emailController, 'Email'),
//               _buildTextField(mobileController, 'Mobile No.'),
//               _buildTextField(addressController, 'Address'),
//               _buildTextField(passwordController, 'Password', obscureText: true),
//               _buildTextField(confirmPasswordController, 'Confirm Password', obscureText: true),
//               SizedBox(height: 15),
//               ElevatedButton(
//                 onPressed: () {
//
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFEA2A00),
//                   minimumSize:  Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child:  Text(
//                   "Register",
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//               Spacer(),
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Already have an Account ",
//                         style: TextStyle(color: Colors.black,fontFamily: 'FontMain ')),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(context,
//                             MaterialPageRoute(builder: (context)=>Loginpage()));
//                       },
//                       child:  Text(
//                         "Sign In",
//                         style: TextStyle(
//                           color: Color(0xFFEA2A00),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false}) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           hintText: hintText,
//           filled: true,
//           fillColor: Colors.grey[200],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
//
