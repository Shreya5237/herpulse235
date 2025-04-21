import 'package:flutter/material.dart';
import 'planning_pregnancy_input_page.dart';
import 'pregnant_input_page.dart';
import 'postpartum_input_page.dart';

class PregnancyInputPage extends StatelessWidget {
  const PregnancyInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F9),
      appBar: AppBar(
        title: const Text('Pregnancy & Postpartum'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Which stage are you in?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 30),
            _PhaseCard(
              icon: Icons.track_changes,
              title: 'Planning Pregnancy',
              color: Colors.purple.shade100,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlanningPregnancyInputPage(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _PhaseCard(
              icon: Icons.pregnant_woman,
              title: 'Ongoing Pregnancy',
              color: Colors.orange.shade100,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PregnantInputPage(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _PhaseCard(
              icon: Icons.baby_changing_station,
              title: 'Postpartum Care',
              color: Colors.green.shade100,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PostpartumInputPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  const _PhaseCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.pinkAccent),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
