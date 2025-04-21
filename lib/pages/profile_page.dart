import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, String> userProfile = {
    "Name": "Divya Sri",
    "Age": "22",
    "Gender": "Female",
    "Weight": "58 kg",
    "Height": "164 cm",
    "BMI": "21.6",
    "Health Goals": "Manage stress, conceive",
    "Medical Conditions": "PCOS, Asthma",
    "Allergies": "Dust, Certain cosmetics",
    "Emergency Contact": "Mom - +91 9876543210",
    "Preferred Language": "English",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile.jpg'), // Your image path
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, size: 20, color: Colors.pinkAccent),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // User Details Cards
            ...userProfile.entries.map((entry) => ProfileField(
              title: entry.key,
              value: entry.value,
            )),
          ],
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String title;
  final String value;

  const ProfileField({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
        trailing: Icon(Icons.edit, color: Colors.pinkAccent),
        onTap: () {
          // You can add navigation to edit page or open a dialog
        },
      ),
    );
  }
}
