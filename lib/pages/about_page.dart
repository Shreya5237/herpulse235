import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About HerPulse"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HerPulse",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.pink),
              ),
              SizedBox(height: 16),
              Text(
                "HerPulse is a holistic digital wellness platform designed exclusively for women. Our mission is to empower women through technology by providing tools for self-care, emergency safety, and health monitoring, all in one place.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Key Features:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              _buildBulletPoint("Health monitoring via smartwatch integration."),
              _buildBulletPoint("Track reproductive and hormonal health."),
              _buildBulletPoint("Emergency SOS support through wearables."),
              _buildBulletPoint("Skin and mental wellness tools."),
              _buildBulletPoint("Virtual consultancy with healthcare professionals."),
              SizedBox(height: 24),
              Text(
                "Our Vision:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                "To redefine how women take care of their health using smart, safe, and user-friendly technology.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                "Developed by:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                "Team HerPulse – Smart India Hackathon 2024",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 18)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
