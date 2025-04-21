// lib/pages/reproductive_health/pregnant_input_page.dart

import 'package:flutter/material.dart';
import 'PregnancyMonitoringPage.dart';

class PregnantInputPage extends StatefulWidget {
  const PregnantInputPage({super.key});
  @override
  _PregnantInputPageState createState() => _PregnantInputPageState();
}

class _PregnantInputPageState extends State<PregnantInputPage> {
  final int totalSteps = 5;
  int currentStep = 0;

  DateTime? lastCheckDate;
  double? weeklyWeight;
  String? bloodPressure;
  double? stressLevel;
  String? fetalNotes;

  void next() => setState(() {
        if (currentStep < totalSteps) currentStep++;
      });

  @override
  Widget build(BuildContext context) {
    final progress = (currentStep + 1) / (totalSteps + 1);

    Widget question;
    switch (currentStep) {
      case 0:
        question = _dateQuestion('Last check‑up date', (d) {
          lastCheckDate = d;
          next();
        });
        break;
      case 1:
        question = _sliderQuestion('Weekly weight (kg)', 30, 100, (v) {
          weeklyWeight = v;
          next();
        });
        break;
      case 2:
        question = _textInputQuestion(
          'Blood pressure (e.g. 120/80)',
          (v) {
            bloodPressure = v;
            next();
          },
          hint: 'Enter here…',
        );
        break;
      case 3:
        question = _sliderQuestion('Stress level (1–10)', 1, 10, (v) {
          stressLevel = v;
          next();
        });
        break;
      case 4:
        question = _textInputQuestion(
          'Fetal movement notes (optional)',
          (v) {
            fetalNotes = v;
            next();
          },
          hint: 'Enter notes…',
        );
        break;
      default:
        question = Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const PregnancyMonitoringPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            child: const Text('Submit'),
          ),
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ongoing Pregnancy'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: const Color(0xFFFDF6F9),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.orange.shade100,
              color: Colors.orange,
              minHeight: 6,
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Container(
                key: ValueKey(currentStep),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 8)
                  ],
                ),
                child: question,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get qStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      );

  Widget _dateQuestion(String label, Function(DateTime) onPicked) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: qStyle),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.calendar_today),
          label: const Text('Pick Date'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade100,
            foregroundColor: Colors.orange,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          onPressed: () async {
            final d = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              builder: (ctx, child) => Theme(
                data: Theme.of(ctx).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                    onSurface: Colors.orange,
                  ),
                ),
                child: child!,
              ),
            );
            if (d != null) onPicked(d);
          },
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: next,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          ),
          child: const Text('Next'),
        )
      ],
    );
  }

  Widget _sliderQuestion(
      String label, double min, double max, Function(double) onEnd) {
    double val = min;
    return StatefulBuilder(builder: (ctx, setSt) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: qStyle),
          const SizedBox(height: 24),
          Slider(
            value: val,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            label: val.round().toString(),
            onChanged: (v) => setSt(() => val = v),
            onChangeEnd: (v) {
              onEnd(v);
              next();
            },
          ),
        ],
      );
    });
  }

  Widget _textInputQuestion(
      String label, Function(String) onSubmit,
      {required String hint}) {
    final ctrl = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: qStyle),
        const SizedBox(height: 16),
        TextField(
          controller: ctrl,
          decoration: InputDecoration(
            hintText: hint,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (ctrl.text.trim().isNotEmpty) {
              onSubmit(ctrl.text.trim());
              next();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: const Text('Next'),
        ),
      ],
    );
  }
}
