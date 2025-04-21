import 'package:flutter/material.dart';

class PregnancyMonitoringPage extends StatelessWidget {
  const PregnancyMonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F9),
      appBar: AppBar(
        title: const Text('Pregnancy Monitoring'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '🤰 Pregnancy Monitoring',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(height: 20),
            _MonitoringTile(
              title: 'Pregnancy Health Score',
              subtitle: 'Tracks weight, vitals, and diet recommendations.',
              icon: Icons.favorite,
              iconColor: Colors.redAccent,
            ),
            SizedBox(height: 16),
            _MonitoringTile(
              title: 'Fetal Development Milestones',
              subtitle: 'Ensures healthy pregnancy progress week-by-week.',
              icon: Icons.child_care,
              iconColor: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}

class _MonitoringTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const _MonitoringTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, color: iconColor, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
