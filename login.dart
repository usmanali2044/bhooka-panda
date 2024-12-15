import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_1/orderscreen.dart';
import 'package:flutter_project_1/signup.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  // Method to handle login
  Future<void> _loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar("Email and password cannot be empty");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Attempt to sign in using Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If successful, navigate to Orderscreen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Orderscreen()));
    } catch (e) {
      _showSnackbar("Login failed: ${e.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Method to show Snackbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDDF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            SizedBox(height: 80),
            Text(
              "Login",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'FontMain',
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Add your details to login",
              style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'FontMain'),
            ),
            SizedBox(height: 30),

            // Email TextField
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Your Email",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Password TextField
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Login Button
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _loginUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEA2A00),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            // Forgot Password
            TextButton(
              onPressed: () {
                // Handle forgot password functionality
              },
              child: Text(
                "Forgot your password?",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            SizedBox(height: 20),
            Text("or Login With", style: TextStyle(color: Colors.black, fontFamily: 'FontMain')),
            SizedBox(height: 20),

            // Facebook Login Button
            ElevatedButton.icon(
              onPressed: () {
                // Implement Facebook Login
              },
              icon: Icon(Icons.facebook, color: Colors.white),
              label: Text(
                "Login with Facebook",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Google Login Button
            ElevatedButton.icon(
              onPressed: () {
                // Implement Google Login
              },
              icon: Icon(Icons.gite, color: Colors.white),
              label: Text(
                "Login with Google",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            Spacer(),

            // SignUp Redirect
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an Account ", style: TextStyle(color: Colors.black, fontFamily: 'FontMain ')),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xFFEA2A00),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
