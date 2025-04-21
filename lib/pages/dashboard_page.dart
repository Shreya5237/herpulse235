import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/health_stat_card.dart';
import '../widgets/quick_access_card.dart';
import 'reproductive_health/comquestion.dart';

class DashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> quickModules = [
    {'title': 'Health Monitoring', 'icon': Icons.favorite},
    {'title': 'Reproductive Health', 'icon': Icons.calendar_today},
    {'title': 'Hormonal Care', 'icon': Icons.health_and_safety},
    {'title': 'Skin Care', 'icon': Icons.face},
    {'title': 'Mental Health', 'icon': Icons.psychology_alt},
    {'title': 'Emergency Safety', 'icon': Icons.sos},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("HerPulse Dashboard"),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: CustomDrawer(userName: 'Shreya', userRole: 'Student'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              const Text(
                "Good Morning, Shreya!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Health Stats
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.spaceEvenly,
                children: const [
                  HealthStatCard(
                    title: 'Heart Rate',
                    value: '72 bpm',
                    icon: Icons.favorite,
                  ),
                  HealthStatCard(
                    title: 'Oxygen',
                    value: '98%',
                    icon: Icons.accessibility_new,
                  ),
                  HealthStatCard(
                    title: 'Sleep',
                    value: '7 hrs',
                    icon: Icons.nightlight_round,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Tip
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Today's Health Tip: Drink more water for better skin!",
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Modules Grid
              GridView.builder(
                shrinkWrap: true,
                itemCount: quickModules.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final title = quickModules[index]['title'] as String;
                  final icon = quickModules[index]['icon'] as IconData;

                  return QuickAccessCard(
                    title: title,
                    icon: icon,
                    onTap: () {
                      if (title == 'Reproductive Health') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ComQuestionPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$title is coming soon!')),
                        );
                      }
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              // Quote
              const Center(
                child: Text(
                  "Keep going, you’ve got this!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
