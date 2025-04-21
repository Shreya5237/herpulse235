// lib/pages/reproductive_health/comquestion.dart

import 'package:flutter/material.dart';
import 'menstrual_cycle_input_page.dart';
import 'planning_pregnancy_input_page.dart';

class ComQuestionPage extends StatelessWidget {
  const ComQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F9),
      appBar: AppBar(
        title: const Text('Which module?'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'What do you need today?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 30),
            _OptionCard(
              icon: Icons.calendar_today,
              title: 'Menstrual Care',
              color: Colors.pink.shade100,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MenstrualCycleInputPage(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _OptionCard(
              icon: Icons.family_restroom,
              title: 'Pregnancy Care',
              color: Colors.purple.shade100,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlanningPregnancyInputPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  const _OptionCard({
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
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.pinkAccent),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
