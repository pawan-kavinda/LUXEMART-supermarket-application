import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project/Screens/login_screen.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

class StarterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 100, top: 50),
            child: Text(
              "LuxeMart",
              style: TextStyle(
                  fontSize: 50, color: Color.fromARGB(255, 3, 34, 10)),
            ),
          ),
          Image.asset(
            'assets/Images/starter2.jpg', // Add your background image asset
            fit: BoxFit.cover,
          ),
          Container(color: Color.fromARGB(255, 255, 255, 255).withOpacity(1)
              // Add a semi-transparent overlay
              ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                  'https://lottie.host/f792ed26-94de-41ec-a711-7777cb4c7d13/KnxRvm96Qd.json',
                  width: 300),
              SizedBox(height: 60.0),
              Text(
                'Savor the Moment: Your Culinary Journey Begins Here!,Step into a Gastronomic Wonderland! Lets shopping',
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 2, 2),
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
                  color: Color.fromARGB(255, 127, 186, 228),
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius as needed
                ),
                child: InkWell(
                  splashColor: Colors.green,
                  onTap: () {
                    Get.to(() => LoginScreen(),
                        transition: Transition.leftToRight);
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
                      )
                          .animate()
                          .fade(duration: 3000.ms)
                          .slideY(curve: Curves.easeIn),
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
