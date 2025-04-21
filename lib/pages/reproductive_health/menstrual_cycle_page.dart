// lib/pages/reproductive_health/menstrual_cycle_page.dart

import 'package:flutter/material.dart';
import '../../models/menstrual_data.dart';

class MenstrualCyclePage extends StatelessWidget {
  final MenstrualData data;
  const MenstrualCyclePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final monthStart = DateTime(data.startDate.year, data.startDate.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(
      data.startDate.year,
      data.startDate.month,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menstrual Health'),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: const Color(0xFFFDF6F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1️⃣ Calendar Overview
            _buildCalendar(monthStart, daysInMonth),

            const SizedBox(height: 24),

            // 2️⃣ Symptom Tracker
            _buildSymptomTracker(),

            const SizedBox(height: 24),

            // 3️⃣ Smart Alerts
            _buildAlerts(),

            const SizedBox(height: 24),

            // 4️⃣ Summary
            _buildSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(DateTime monthStart, int days) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📅 Calendar Overview',
          style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (ctx, i) {
            final day = monthStart.add(Duration(days: i));
            Color bg = Colors.grey.shade200;

            // Period days
            if (!day.isBefore(data.startDate) && !day.isAfter(data.endDate)) {
              bg = Colors.red.shade200;
            }
            // Fertile window (day 10–14)
            else if (day.isAfter(data.startDate.add(const Duration(days: 9))) &&
                     day.isBefore(data.startDate.add(const Duration(days: 15)))) {
              bg = Colors.green.shade200;
            }
            // Ovulation day (day 14)
            else if (day.isAtSameMomentAs(data.startDate.add(const Duration(days: 14)))) {
              bg = Colors.orange.shade200;
            }
            // PMS days (7 days before start)
            else if (day.isAfter(data.startDate.subtract(const Duration(days: 8))) &&
                     day.isBefore(data.startDate)) {
              bg = Colors.purple.shade100;
            }

            return GestureDetector(
              onTap: () => _showDayDetails(ctx, day),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(day.day.toString()),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        // Legend
        Wrap(
          spacing: 12,
          children: const [
            _LegendDot(color: Colors.red, label: 'Period'),
            _LegendDot(color: Colors.green, label: 'Fertile'),
            _LegendDot(color: Colors.orange, label: 'Ovulation'),
            _LegendDot(color: Colors.purple, label: 'PMS'),
          ],
        ),
      ],
    );
  }

  Widget _buildSymptomTracker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🤕 Symptom Tracker',
          style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
        ),
        const SizedBox(height: 8),
        Text('Pain Level: ${data.painLevel}/10'),
        Slider(
          value: data.painLevel.toDouble(),
          min: 0,
          max: 10,
          divisions: 10,
          onChanged: null, // disabled
        ),
        Wrap(
          spacing: 8,
          children: data.symptoms
              .map((s) => Chip(label: Text(s), backgroundColor: Colors.pink.shade50))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🔔 Smart Alerts',
          style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
        ),
        const SizedBox(height: 4),
        const ListTile(
          leading: Icon(Icons.notifications_active, color: Colors.pinkAccent),
          title: Text('Upcoming period reminder'),
        ),
        const ListTile(
          leading: Icon(Icons.shopping_bag, color: Colors.pinkAccent),
          title: Text('Sanitary product reminder'),
        ),
        const ListTile(
          leading: Icon(Icons.timeline, color: Colors.pinkAccent),
          title: Text('Fertility window alert'),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '🌸 Menstrual Health',
          style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
        ),
        SizedBox(height: 8),
        Text('🩸 Cycle Tracking\n• Period start/end dates\n• Flow intensity'),
        SizedBox(height: 8),
        Text('📍 Ovulation & Fertility Prediction\n• AI-based cycle prediction\n• Fertility window alerts'),
        SizedBox(height: 8),
        Text('📲 Smart Reminders\n• Sanitary pad/tampon reminders'),
        SizedBox(height: 8),
        Text('📉 Pain Monitoring\n• Monthly pain level recording\n• Pain trend detection'),
      ],
    );
  }

  void _showDayDetails(BuildContext ctx, DateTime day) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text('Details for ${day.day}/${day.month}/${day.year}'),
        content: const Text(
          'Flow: Medium\nSymptoms: Cramps, Fatigue\nNotes: Took a hot bath.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
