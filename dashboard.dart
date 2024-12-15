import 'package:flutter/material.dart';
import 'package:flutter_project_1/login.dart';
import 'package:flutter_project_1/signup.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );


    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);


    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDDF),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration:  BoxDecoration(
                color: Color(0xFFEA2A00),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Placeholder
                    Container(
                      width: 200, // Diameter of the circle
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/img/pandalogo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                     SizedBox(height: 10),
                     Text(
                      "Resturant",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFDDF),
                      ),
                    ),
                     SizedBox(height: 10,),
                     Text(
                      "",
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontSize: 20,
                        color: Color(0xFFFFFDDF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
             Spacer(),
           // button -> login and signup
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>Loginpage())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEA2A00),
                      minimumSize:  Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Color(0xFFFFFDDF),fontFamily: 'FontMain',),
                    ),
                  ),
                   SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEA2A00),
                      minimumSize:  Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text(
                      "Create an Account",
                      style: TextStyle(fontSize: 18, color:Color(0xFFFFFDDF),fontFamily:  'FontMain',),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
