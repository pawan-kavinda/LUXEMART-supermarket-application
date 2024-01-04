import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Text(
                  "Hello",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
            ),
            Divider(
              height: 5,
              thickness: 4,
            ),
            ListTile(
              title: Text(
                'Address',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Address', style: TextStyle(fontSize: 24)),
              leading: Icon(Icons.image),
              trailing: Icon(Icons.arrow_back),
              onTap: () async {},
            ),
            ListTile(
              title: Text(
                'Orders',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.wallet),
              trailing: Icon(Icons.arrow_back),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Wishlist',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.favorite),
              trailing: Icon(Icons.arrow_back),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Viewed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.remove_red_eye),
              trailing: Icon(Icons.arrow_back),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.lock),
              trailing: Icon(Icons.arrow_back),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.arrow_back),
              onTap: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
