// lib/pages/reproductive_health/menstrual_cycle_input_page.dart
import '../../models/menstrual_data.dart';
import 'menstrual_cycle_page.dart';

import 'package:flutter/material.dart';

class MenstrualCycleInputPage extends StatefulWidget {
  const MenstrualCycleInputPage({super.key});

  @override
  State<MenstrualCycleInputPage> createState() => _MenstrualCycleInputPageState();
}

class _MenstrualCycleInputPageState extends State<MenstrualCycleInputPage> {
  int currentPage = 0;

  DateTime? startDate;
  DateTime? endDate;
  String? flowIntensity;
  int? painLevel;
  List<String> symptoms = [];
  String? productPreference;
  String? dietType;
  String? meals;
  String? waterIntake;
  String? sleepHours;
  String? activity;

  final pageCount = 11;

  void nextPage() {
    if (currentPage < pageCount) {
      setState(() => currentPage++);
    } else {
      // TODO: submit data
    }
  }

  Widget buildQuestion() {
    switch (currentPage) {
      case 0:
        return _datePicker("📅 Start Date", (d) => startDate = d);
      case 1:
        return _datePicker("📅 End Date", (d) => endDate = d);
      case 2:
        return _choiceQuestion("Flow Intensity", ["Light", "Medium", "Heavy"], (v) => flowIntensity = v);
      case 3:
        return _sliderQuestion("Pain Level (1-10)", 1, 10, (v) => painLevel = v.toInt());
      case 4:
        return _multiSelectQuestion("Symptoms", ["Cramps", "Bloating", "Fatigue", "Back Pain"], (v) => symptoms = v);
      case 5:
        return _choiceQuestion("Product Preference", ["Pad", "Tampon", "Cup"], (v) => productPreference = v);
      case 6:
        return _choiceQuestion("Diet Type", ["Veg", "Non‑Veg"], (v) => dietType = v);
      case 7:
        return _textInputQuestion("Meals/Snacks", (v) => meals = v, hint: "e.g. Breakfast, Snack");
      case 8:
        return _textInputQuestion("Water Intake (ml)", (v) => waterIntake = v, hint: "e.g. 2000");
      case 9:
        return _textInputQuestion("Sleep (hrs)", (v) => sleepHours = v, hint: "e.g. 7");
      case 10:
        return _textInputQuestion("Activity / Workout", (v) => activity = v, hint: "e.g. 30 min walk");
      default:
        return const Center(child: Text("Thank you!"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (currentPage + 1) / (pageCount + 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Menstrual Tracker"),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: const Color(0xFFFDF6F9),
      body: Column(
        children: [
          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.pink.shade100,
              color: Colors.pinkAccent,
              minHeight: 8,
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
              child: Container(
                key: ValueKey(currentPage),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: buildQuestion(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _qStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.pinkAccent,
      );

  Widget _questionWrapper({required Widget child}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: SingleChildScrollView(child: child)),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: nextPage,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          ),
          child: const Text("Next", style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _datePicker(String label, Function(DateTime) onPicked) {
    return _questionWrapper(
      child: Column(
        children: [
          Text(label, style: _qStyle),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.calendar_today),
            label: const Text("Pick Date"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade100,
              foregroundColor: Colors.pinkAccent,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
              if (d != null) {
                onPicked(d);
                nextPage();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _choiceQuestion(String label, List<String> opts, Function(String) onSelect) {
    return _questionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _qStyle),
          const SizedBox(height: 24),
          ...opts.map((o) => Card(
                color: Colors.pink.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(o),
                  leading: const Icon(Icons.check_circle_outline, color: Colors.pinkAccent),
                  onTap: () {
                    onSelect(o);
                    nextPage();
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget _sliderQuestion(String label, double min, double max, Function(double) onEnd) {
    double val = min;
    return _questionWrapper(
      child: StatefulBuilder(builder: (ctx, setSt) {
        return Column(
          children: [
            Text(label, style: _qStyle),
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
                nextPage();
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _multiSelectQuestion(String label, List<String> opts, Function(List<String>) onSubmit) {
    List<String> sel = [];
    return _questionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _qStyle),
          const SizedBox(height: 16),
          ...opts.map((o) => CheckboxListTile(
                title: Text(o),
                value: sel.contains(o),
                activeColor: Colors.pinkAccent,
                onChanged: (v) => setState(() => v! ? sel.add(o) : sel.remove(o)),
              )),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              onSubmit(sel);
              nextPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text("Next", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _textInputQuestion(String label, Function(String) onSubmit, {required String hint}) {
    final ctrl = TextEditingController();
    return _questionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _qStyle),
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
                // inside _MenstrualCycleInputPageState
                  void nextPage() {
                    if (currentPage < pageCount) {
                      setState(() => currentPage++);
                    } else {
                      // All questions done → navigate
                      final data = MenstrualData(
                        startDate: startDate!,
                        endDate: endDate!,
                        flowIntensity: flowIntensity!,
                        painLevel: painLevel!,
                        symptoms: symptoms,
                        productPreference: productPreference!,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MenstrualCyclePage(data: data),
                        ),
                      );
                    }
                  }

              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text("Next", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
