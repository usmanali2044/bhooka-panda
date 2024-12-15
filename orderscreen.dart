import 'package:flutter/material.dart';
import 'package:flutter_project_1/animation/slidepage.dart';
import 'package:flutter_project_1/checkout.dart';
import 'package:flutter_project_1/selectaddress.dart';
import 'package:flutter_project_1/support_about.dart';
import 'package:flutter_project_1/userprofile.dart';
import 'package:flutter_project_1/cart.dart';


class Orderscreen extends StatefulWidget {

  final String address ;
  Orderscreen({this.address = 'Select Area'});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  String deliverTo = '';
  List<CartItem> cartItems = [];

  void initState() {
    super.initState();
    deliverTo = widget.address;
  }

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      // Check if the item already exists in the cart
      final existingItem = cartItems.firstWhere(
            (cartItem) => cartItem.name == item['name'],
        orElse: () => CartItem(
          name: '',
          Description: '',
          price: '',
          image: '',
        ),
      );

      if (existingItem.name.isNotEmpty) {
        existingItem.quantity++;
      } else {
        cartItems.add(CartItem(
          name: item['name'],
          Description: item['description'],
          price: item['price'],
          image: item['image'],
        ));
      }
    });
  }

  void goToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(cartItems: cartItems),
      ),
    );
  }

  final List<String> images = [
    'assets/img/image2.jpg',
    'assets/img/image3.jpg',
    'assets/img/image1.jpg',
  ];

  final List<String> Foodlist = [
    'Beef Burgers',
    'Chicken Burgers',
    'Platters',
    'Fries',
    'Sides',
    'Beverages'
  ];

  // Data for each category
  final Map<String, List<Map<String, dynamic>>> foodItems = {
    'Beef Burgers': [
      {
        'name': 'Smashed Burger',
        'description': 'Smashed Patty,grill onions and Bun',
        'price': 'Rs. 950',
        'image': 'assets/img/smashburger.jpg',
      },
      {
        'name': 'Molten Lava',
        'description': 'cheddar sticks,smashed patty, grill onions',
        'price': 'Rs. 1450',
        'image': 'assets/img/moltenlava.jpg',
      },
      {
        'name': 'Swiss Mushroom',
        'description': 'Tangy Mushroom,Melted Chesse,beef patty',
        'price': 'Rs. 1150',
        'image': 'assets/img/swiss.jpg',
      },
    ],
    'Chicken Burgers': [
      {
        'name': 'Zinger Burger',
        'description': 'Crispy Thigh,Potato Bun and Lettuce',
        'price': 'Rs. 1450',
        'image': 'assets/img/zinger.jpg',
      },
      {
        'name': 'Grill Burger',
        'description': 'K&Ns Patty ,Lettuce,Soft Bun',
        'price': 'Rs. 1150',
        'image': 'assets/img/patty.jpg',
      },
    ],

    'Platters': [
      {
        'name': 'Bhooka Platter',
        'description': '6 cheddar sticks,12 buffalo wings',
        'price': 'Rs. 999',
        'image': 'assets/img/platter1.jpg',
      },
      {
        'name': 'Classic Platter',
        'description': '6 roasted Rolls,12 wings 1 drink, ',
        'price': 'Rs. 1250.00',
        'image': 'assets/img/platter2.jpg',
      },

    ],
    'Fries': [
      {
        'name': 'Loaded fries',
        'description': 'Chicken Chunks,AnimalSauce,Onions,CurlyFries',
        'price': 'Rs. 630',
        'image': 'assets/img/loaded.jpg',
      },
      {
        'name': 'Fries',
        'description': 'Golden Crispy Fries',
        'price': 'Rs. 310',
        'image': 'assets/img/fries.jpg',
      },
    ],
    'Sides': [
      {
        'name': 'Chicken Piece',
        'description': 'Crispy Golden Fried Chicken',
        'price': 'Rs. 290',
        'image': 'assets/img/fried.jpg',
      },
    ],
    'Beverages' :[
      {
        'name' : 'Coca Cola 345ml',
        'description' : 'Frizzy Carbonated Drink',
        'price': 'Rs 150',
        'image': 'assets/img/coke.jpg'
      },
      {
        'name' : 'Sparkling Water',
        'description' : '345 ml Purfied Water Bottle',
        'price': 'Rs 70',
        'image': 'assets/img/water.jpg'
      },
    ]
  };

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF8DFDDD1),
        appBar: AppBar(
          backgroundColor: Color(0xFFEA2A00) ,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DELIVER TO',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFFFFDDF),
                      fontWeight: FontWeight.bold,
                      fontFamily: "FontMain",
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        deliverTo,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFFFDDF),
                          fontWeight: FontWeight.bold,
                          fontFamily: "FontMain",
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                       final updatedAddress = await Navigator.push(context, SlidePageRoute(page: Selectaddress(), direction: AxisDirection.up));
                       if(updatedAddress!=null){
                         setState(() {
                           deliverTo = updatedAddress;
                         });
                       }
                        },
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: Color(0xFFFFFDDF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Stack(
                      children: [
                        Icon(Icons.shopping_cart, color: Color(0xFFFFFDDF), size: 28), // Base cart icon
                        if (cartItems.isNotEmpty)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Text(
                                '${cartItems.length}', // Total quantity in cart
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    onPressed: () {
                      goToCheckout();
                    },
                  ),


                  IconButton(
                    icon: Icon(Icons.help_outline, color: Color(0xFFFFFDDF)),
                    onPressed: () {
                      Navigator.push(context, SlidePageRoute(page: SupportAbout(), direction: AxisDirection.up));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person_outline, color: Color(0xFFFFFDDF)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      body: Column(
        children: <Widget>[
          // Top carousel
          Container(
            height: 200,
            width: double.infinity,
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),


          Container(
            height: 70,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Foodlist.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(

                    decoration: BoxDecoration(
                      color: Color(0xFFEA2A00)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          Foodlist[index],
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'FontMain',
                            color: selectedIndex == index
                                ? Color(0xFFFFFDDF)
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Food items list
          Expanded(
            child: ListView.builder(
              itemCount: foodItems[Foodlist[selectedIndex]]?.length ?? 0,
              itemBuilder: (context, index) {
                final item = foodItems[Foodlist[selectedIndex]]?[index];
                if (item == null) return SizedBox();

                return Card(
                  color: Color(0xFFFFFDDF),
                  margin: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Image.asset(
                        item['image'],
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(item['description']),
                            SizedBox(height: 4.0),
                            Text(
                              item['price'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEA2A00),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                addToCart(item);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFEA2A00),
                                   ),
                              child: Text("Add",style:TextStyle(color: Color(0xFFFFFDDF)) ,),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

