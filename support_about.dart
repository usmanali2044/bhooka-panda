import 'package:flutter/material.dart';

class SupportAbout extends StatefulWidget {
  const SupportAbout({super.key});

  @override
  State<SupportAbout> createState() => _SupportAboutState();
}

class _SupportAboutState extends State<SupportAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDDF),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon:Icon(Icons.keyboard_arrow_down),iconSize: 30,color: Colors.black,),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 250,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(image: AssetImage('assets/img/pandalogo.png'),
                      fit:BoxFit.cover,
                    )
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text("Support Center",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                  Text("For Queries,please contact us at : ",style: TextStyle(fontSize: 20),),
                  SizedBox(height: 15,),
                  Text("232383@students.au.edu.pk",style: TextStyle(fontSize: 20),),
                  SizedBox(height: 15,),
                  Text("232109@students.au.edu.pk",style: TextStyle(fontSize: 20),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
