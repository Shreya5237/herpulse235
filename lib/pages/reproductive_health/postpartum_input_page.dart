import 'package:flutter/material.dart';
import 'postpartum_page.dart';

class PostpartumInputPage extends StatefulWidget {
  const PostpartumInputPage({super.key});

  @override
  State<PostpartumInputPage> createState() => _PostpartumInputPageState();
}

class _PostpartumInputPageState extends State<PostpartumInputPage> {
  final int totalSteps = 5;
  int currentStep = 0;

  DateTime? deliveryDate;
  bool? breastfeeding;
  double? motherSleep;
  double? babySleep;
  List<String> symptoms = [];
  double? recoveryPain;

  void nextStep() {
    setState(() {
      if (currentStep < totalSteps) {
        currentStep++;
      }
    });
  }

  void submitData() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PostpartumPage(
          deliveryDate: deliveryDate,
          breastfeeding: breastfeeding,
          motherSleep: motherSleep,
          babySleep: babySleep,
          symptoms: symptoms,
          recoveryPain: recoveryPain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = (currentStep + 1) / (totalSteps + 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Postpartum Care'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFFDF6F9),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.green.shade100,
              color: Colors.green,
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
                child: _buildStep(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep() {
    switch (currentStep) {
      case 0:
        return _dateQuestion('When was your delivery?', (date) {
          deliveryDate = date;
          nextStep();
        });
      case 1:
        return _yesNoQuestion('Are you currently breastfeeding?', (val) {
          breastfeeding = val;
          nextStep();
        });
      case 2:
        return _sliderQuestion(
          'How many hours do you sleep?',
          0,
          12,
          (val) {
            motherSleep = val;
            nextStep();
          },
        );
      case 3:
        return _multiSelectQuestion(
          'Which symptoms have you experienced?',
          ['Mood swings', 'Fatigue', 'Pain', 'Anxiety'],
          (val) {
            symptoms = val;
            nextStep();
          },
        );
      case 4:
        return _sliderQuestion(
          'Rate your recovery pain (1–10)',
          1,
          10,
          (val) {
            recoveryPain = val;
            nextStep();
          },
        );
      default:
        return Center(
          child: ElevatedButton(
            onPressed: submitData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            child: const Text('Submit'),
          ),
        );
    }
  }

  TextStyle get qStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
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
            backgroundColor: Colors.green.shade100,
            foregroundColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              builder: (ctx, child) => Theme(
                data: Theme.of(ctx).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    onSurface: Colors.green,
                  ),
                ),
                child: child!,
              ),
            );
            if (picked != null) onPicked(picked);
          },
        ),
      ],
    );
  }

  Widget _yesNoQuestion(String label, Function(bool) onAnswer) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: qStyle),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _yesNoButton('Yes', true, onAnswer),
            const SizedBox(width: 20),
            _yesNoButton('No', false, onAnswer),
          ],
        ),
      ],
    );
  }

  Widget _yesNoButton(String text, bool val, Function(bool) onTap) {
    return ElevatedButton(
      onPressed: () => onTap(val),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text),
    );
  }

  Widget _sliderQuestion(
      String label, double min, double max, Function(double) onChanged) {
    double sliderValue = (min + max) / 2;

    return StatefulBuilder(
      builder: (context, setSt) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: qStyle),
            const SizedBox(height: 24),
            Slider(
              value: sliderValue,
              min: min,
              max: max,
              divisions: (max - min).toInt(),
              label: sliderValue.round().toString(),
              onChanged: (value) => setSt(() => sliderValue = value),
              onChangeEnd: onChanged,
            ),
          ],
        );
      },
    );
  }

  Widget _multiSelectQuestion(
      String label, List<String> options, Function(List<String>) onSubmit) {
    List<String> selected = [];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: qStyle),
        const SizedBox(height: 16),
        ...options.map(
          (option) => CheckboxListTile(
            title: Text(option),
            value: selected.contains(option),
            activeColor: Colors.green,
            onChanged: (val) {
              setState(() {
                if (val == true) {
                  selected.add(option);
                } else {
                  selected.remove(option);
                }
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => onSubmit(selected),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: const Text('Next'),
        ),
      ],
    );
  }
}
