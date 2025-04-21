// lib/pages/reproductive_health/planning_pregnancy_page.dart

import 'package:flutter/material.dart';
import '../../models/planning_pregnancy_data.dart';

class PlanningPregnancyPage extends StatelessWidget {
  final PlanningPregnancyData data;
  const PlanningPregnancyPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Build a calendar for the month of lastOvulationDate (or today if null)
    final base = data.lastOvulationDate ?? DateTime.now();
    final monthStart = DateTime(base.year, base.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(base.year, base.month);

    // Fertile window: 5 days before and 1 day after the ovulation day
    final ovulationDay = data.lastOvulationDate;
    final fertileStart = ovulationDay?.subtract(const Duration(days: 5));
    final fertileEnd   = ovulationDay?.add(const Duration(days: 1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning Pregnancy Summary'),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: const Color(0xFFFDF6F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1️⃣ Calendar Overview
            const Text(
              '📅 Calendar Overview',
              style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daysInMonth,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (ctx, i) {
                final day = monthStart.add(Duration(days: i));
                Color bg = Colors.grey.shade200;

                // Fertile window
                if (fertileStart != null && fertileEnd != null &&
                    !day.isBefore(fertileStart) &&
                    !day.isAfter(fertileEnd)) {
                  bg = Colors.green.shade200;
                }
                // Ovulation day
                if (ovulationDay != null &&
                    day.year == ovulationDay.year &&
                    day.month == ovulationDay.month &&
                    day.day == ovulationDay.day) {
                  bg = Colors.orange.shade200;
                }

                return GestureDetector(
                  onTap: () => _showDayDetails(context, day),
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
            Wrap(
              spacing: 12,
              children: const [
                _LegendDot(color: Colors.green, label: 'Fertile Window'),
                _LegendDot(color: Colors.orange, label: 'Ovulation'),
              ],
            ),

            const SizedBox(height: 24),

            // 2️⃣ Symptom Tracker
            const Text(
              '🤕 Symptom Tracker',
              style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 8),
            Text('Stress Level: ${data.stressLevel.toStringAsFixed(1)}/10'),
            Slider(
              value: data.stressLevel,
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: null,
            ),
            const SizedBox(height: 8),
            Text(
              'Fetal Notes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(data.fetalNotes.isEmpty ? 'None' : data.fetalNotes),

            const SizedBox(height: 24),

            // 3️⃣ Smart Alerts
            const Text(
              '🔔 Smart Alerts',
              style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 4),
            if (ovulationDay != null && ovulationDay.isAfter(DateTime.now()))
              ListTile(
                leading: const Icon(Icons.notifications_active, color: Colors.pinkAccent),
                title: Text(
                  'Ovulation on ${ovulationDay.day}/${ovulationDay.month}/${ovulationDay.year}',
                ),
              )
            else
              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('No upcoming alerts'),
              ),

            const SizedBox(height: 24),

            // 4️⃣ Input Summary
            const Text(
              '📝 Your Input Summary',
              style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 8),
            _buildRow('Trying to conceive?', data.tryingToConceive ? 'Yes' : 'No'),
            _buildRow(
              'Last ovulation/intercourse',
              ovulationDay == null
                ? 'Not provided'
                : '${ovulationDay.day}/${ovulationDay.month}/${ovulationDay.year}',
            ),
            _buildRow('Pregnancy confirmed?', data.pregnancyConfirmed ? 'Yes' : 'No'),
            _buildRow('Weekly weight', '${data.weeklyWeight.toStringAsFixed(1)} kg'),
            _buildRow('Blood pressure', data.bloodPressure),

            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                child: const Text('Back to Dashboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDayDetails(BuildContext context, DateTime day) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Details: ${day.day}/${day.month}/${day.year}'),
        content: const Text(
          'Tap on any day in future releases to see details.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex:2, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex:3, child: Text(value)),
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
        Container(width:12, height:12, decoration: BoxDecoration(color:color, shape:BoxShape.circle)),
        const SizedBox(width:4),
        Text(label),
      ],
    );
  }
}
