import 'package:flutter/material.dart';
import 'package:gpa_calculator/screen/about_us_Screen.dart';

class Drawers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 103, 202, 118),
            ),
            child: Column(
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Image.asset(
                  'lib/assets/OIP.jpg',
                  height: 100,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.man),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
          ),
          // Add more options here if needed
        ],
      ),
    );
  }
}
