import 'package:flutter/material.dart';
import 'package:project/Screens/login_screen.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

class StarterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/Images/starter2.jpg', // Add your background image asset
            fit: BoxFit.cover,
          ),
          Container(
            color:
                Colors.black.withOpacity(0.6), // Add a semi-transparent overlay
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'WELCOME',
                style: TextStyle(
                  color: Color.fromARGB(255, 232, 212, 67),
                  fontSize: 32.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 60.0),
              Text(
                'Savor the Moment: Your Culinary Journey Begins Here!,Step into a Gastronomic Wonderland! Lets shopping',
                style: TextStyle(
                  color: Color.fromARGB(255, 196, 199, 196),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
              Container(
                width: 160.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 194, 189, 49),
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius as needed
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: const Color.fromARGB(255, 2, 2, 2),
                      ),
                      Text(
                        'Get Started',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 11, 10, 10),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
