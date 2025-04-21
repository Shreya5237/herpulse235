import 'package:flutter/material.dart';

class QuickAccessCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const QuickAccessCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.pink[300],
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.white),
              SizedBox(height: 10),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
