

import 'package:flutter/material.dart';
import 'package:flutter_project_1/animation/slidepage.dart';
import 'package:flutter_project_1/orderscreen.dart';

class Selectaddress extends StatefulWidget {
  const Selectaddress({super.key});

  @override
  State<Selectaddress> createState() => _SelectaddressState();
}

class _SelectaddressState extends State<Selectaddress> {
  String selectedCity = "Your City"; // Default city text
  String selectedArea = "Area"; // Default area text

  void showCitySelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        List<String> cities = ["ISB", "RWP" ];
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(cities[index], style: TextStyle(fontFamily: "FontMain")),
                onTap: () {
                  setState(() {
                    selectedCity = cities[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  void showAreaSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        List<String> areas = ["I-8", "Air University", "E-9", "H-12", "Faizabad"];
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: areas.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(areas[index], style: TextStyle(fontFamily: "FontMain")),
                onTap: () {
                  setState(() {
                    selectedArea = areas[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEA2A00),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 30,
              color: Color(0xFFFFFDDF),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEA2A00),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
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
                      "Delivery",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFDDF),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please Select Your Location",
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "City",
                    style: TextStyle(color: Color(0xFFFFFDDF), fontFamily: "FontMain"),
                  ),
                  TextField(
                    onTap: showCitySelector,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: selectedCity,
                      hintStyle: TextStyle(fontFamily: "FontMain", color: Color(0xFFFFFDDF)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFFDDF), width: 2.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFFDDF), width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Your Area",
                    style: TextStyle(color: Color(0xFFFFFDDF), fontFamily: "FontMain"),
                  ),
                  TextField(
                    onTap: showAreaSelector,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: selectedArea,
                      hintStyle: TextStyle(fontFamily: "FontMain", color: Color(0xFFFFFDDF)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFFDDF), width: 2.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFFDDF), width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context,"$selectedArea" "$selectedCity" );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFFDDF),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Confirm",
                  style: TextStyle(fontSize: 18, color: Color(0xFFEA2A00), fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

