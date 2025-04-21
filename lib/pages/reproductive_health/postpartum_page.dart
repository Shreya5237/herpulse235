// postpartum_page.dart

import 'package:flutter/material.dart';

class PostpartumPage extends StatelessWidget {
  final DateTime? deliveryDate;
  final bool? breastfeeding;
  final double? motherSleep;
  final double? babySleep;
  final List<String> symptoms;
  final double? recoveryPain;

  const PostpartumPage({
    super.key,
    this.deliveryDate,
    this.breastfeeding,
    this.motherSleep,
    this.babySleep,
    required this.symptoms,
    this.recoveryPain,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F9),
      appBar: AppBar(
        title: const Text("🛌 Postpartum Care"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🩺 Recovery Summary",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text("• Hormonal recovery tracking started from ${deliveryDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}"),
            Text("• Breastfeeding: ${breastfeeding == true ? 'Yes' : 'No'}"),
            Text("• Your sleep: ${motherSleep?.toStringAsFixed(1) ?? '-'} hrs"),
            Text("• Baby sleep: ${babySleep?.toStringAsFixed(1) ?? '-'} hrs"),
            Text("• Symptoms reported: ${symptoms.join(', ')}"),
            Text("• Pain Level: ${recoveryPain?.toStringAsFixed(1) ?? '-'} / 10"),
            const SizedBox(height: 30),
            const Text(
              "✨ Recommendations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("✔ Hormonal recovery is being tracked"),
            const Text("✔ Mood, stress, and pain levels monitored"),
            const Text("✔ Personalized postpartum workout & diet plan provided"),
          ],
        ),
      ),
    );
  }
}
