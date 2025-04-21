// lib/widgets/custom_drawer.dart
import 'package:flutter/material.dart';
import '../pages/about_page.dart';
import '../pages/profile_page.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userRole;

  CustomDrawer({required this.userName, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.pinkAccent),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                SizedBox(height: 10),
                Text(userName,
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                Text(userRole,
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text('Support'),
            onTap: () {},
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
