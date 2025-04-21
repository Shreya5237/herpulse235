// lib/pages/reproductive_health/planning_pregnancy_input_page.dart

import 'package:flutter/material.dart';
import '../../models/planning_pregnancy_data.dart';
import 'planning_pregnancy_page.dart';

class PlanningPregnancyInputPage extends StatefulWidget {
  const PlanningPregnancyInputPage({super.key});

  @override
  State<PlanningPregnancyInputPage> createState() =>
      _PlanningPregnancyInputPageState();
}

class _PlanningPregnancyInputPageState
    extends State<PlanningPregnancyInputPage> {
  final int totalSteps = 7;
  int currentStep = 0;

  bool? tryingToConceive;
  DateTime? lastOvulationDate;
  bool? confirmedPregnancy;
  double? weeklyWeight;
  String? bloodPressure;
  double? stressLevel;
  String? fetalNotes;

  void next() => setState(() {
        if (currentStep < totalSteps) {
          currentStep++;
        } else {
          // Build data model and navigate
          final data = PlanningPregnancyData(
            tryingToConceive: tryingToConceive ?? false,
            lastOvulationDate: lastOvulationDate,
            pregnancyConfirmed: confirmedPregnancy ?? false,
            weeklyWeight: weeklyWeight ?? 0,
            bloodPressure: bloodPressure ?? '',
            stressLevel: stressLevel ?? 0,
            fetalNotes: fetalNotes ?? '',
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => PlanningPregnancyPage(data: data),
            ),
          );
        }
      });

  @override
  Widget build(BuildContext context) {
    final progress = (currentStep + 1) / (totalSteps + 1);

    Widget question;
    switch (currentStep) {
      case 0:
        question = _yesNoQuestion(
          'Trying to conceive?',
          (val) {
            tryingToConceive = val;
            next();
          },
        );
        break;
      case 1:
        question = _dateQuestion(
          'Last ovulation/intercourse (optional)',
          (date) {
            lastOvulationDate = date;
            next();
          },
        );
        break;
      case 2:
        question = _yesNoQuestion(
          'Pregnancy confirmed?',
          (val) {
            confirmedPregnancy = val;
            next();
          },
        );
        break;
      case 3:
        question = _sliderQuestion(
          'Weekly weight (kg)',
          30,
          100,
          (v) {
            weeklyWeight = v;
            next();
          },
        );
        break;
      case 4:
        question = _textInputQuestion(
          'Blood pressure (e.g. 120/80)',
          (v) {
            bloodPressure = v;
            next();
          },
          hint: 'Enter here…',
        );
        break;
      case 5:
        question = _sliderQuestion(
          'Stress level (1–10)',
          1,
          10,
          (v) {
            stressLevel = v;
            next();
          },
        );
        break;
      case 6:
        question = _textInputQuestion(
          'Fetal movement notes (optional)',
          (v) {
            fetalNotes = v;
            next();
          },
          hint: 'Enter your notes…',
        );
        break;
      default:
        // This won't be shown because next() navigates on currentStep > totalSteps
        question = const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning Pregnancy'),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: const Color(0xFFFDF6F9),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.pink.shade100,
              color: Colors.pinkAccent,
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
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
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
        color: Colors.pinkAccent,
      );

  Widget _yesNoQuestion(String label, Function(bool) onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: qStyle),
        const SizedBox(height: 30),
        ToggleButtons(
          isSelected: [tryingToConceive == true, tryingToConceive == false],
          onPressed: (i) => onTap(i == 0),
          borderRadius: BorderRadius.circular(12),
          selectedColor: Colors.white,
          fillColor: Colors.pinkAccent,
          color: Colors.pinkAccent,
          children: const [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text('Yes')),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text('No')),
          ],
        ),
      ],
    );
  }

  Widget _dateQuestion(String label, Function(DateTime) onPicked) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: qStyle),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          icon: const Icon(Icons.calendar_today),
          label: const Text('Pick Date'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple.shade100,
            foregroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                    primary: Colors.pinkAccent,
                    onPrimary: Colors.white,
                    onSurface: Colors.pink,
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
            backgroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
            backgroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: const Text('Next'),
        ),
      ],
    );
  }
}
