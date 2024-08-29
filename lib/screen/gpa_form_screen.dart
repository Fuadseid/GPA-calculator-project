import 'package:flutter/material.dart';

class Grade {
  static double getGradePoint(String letter) {
    switch (letter.toUpperCase()) {
      case 'A+':
      case 'A':
        return 4.0;
      case 'A-':
        return 3.75;
      case 'B+':
        return 3.5;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.75;
      case 'C+':
        return 2.5;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.5;
      case 'D':
        return 1.0;
      case 'F':
        return 0.0;
      default:
        throw ArgumentError('Invalid grade: $letter');
    }
  }
}

class GpaFormScreen extends StatefulWidget {
  GpaFormScreen({
    super.key,
    required this.enterednumber,
  });
  final TextEditingController enterednumber;

  @override
  State<GpaFormScreen> createState() {
    return _GpaFormScreen();
  }
}

class _GpaFormScreen extends State<GpaFormScreen> {
  final List<TextEditingController> _titleControllers = [];
  final List<TextEditingController> _creditControllers = [];
  final List<String> _selectedGrades = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _titleControllers) {
      controller.dispose();
    }
    for (var controller in _creditControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double? calculateGPA() {
    double totalPoints = 0;
    double totalCredits = 0;

    for (int i = 0; i < _creditControllers.length; i++) {
      String title = _titleControllers[i].text.trim();
      double credits = double.tryParse(_creditControllers[i].text.trim()) ?? -1;
      String grade = _selectedGrades[i];

      // Check if any field is empty or invalid
      if (title.isEmpty || credits < 0) {
        return null; // Indicate that the calculation cannot proceed
      }

      double gradePoint = Grade.getGradePoint(grade);
      totalPoints += gradePoint * credits;
      totalCredits += credits;
    }

    return totalCredits > 0 ? totalPoints / totalCredits : null;
  }

  void addCourse() {
    setState(() {
      _titleControllers.add(TextEditingController());
      _creditControllers.add(TextEditingController());
      _selectedGrades.add('A'); // Default grade
    });
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int number = int.tryParse(widget.enterednumber.text) ?? 0;

    // Ensure the correct number of controllers and grades are initialized
    while (_titleControllers.length < number) {
      addCourse();
    }
    while (_titleControllers.length > number) {
      _titleControllers.removeLast().dispose();
      _creditControllers.removeLast().dispose();
      _selectedGrades.removeLast();
    }

    List<Widget> containers = _titleControllers.asMap().entries.map((entry) {
      int index = entry.key;
      TextEditingController titleController = entry.value;
      TextEditingController creditController = _creditControllers[index];

      return Padding(
        padding: const EdgeInsets.all(2),
        child: SizedBox(
          width: double.infinity,
          height: 90,
          child: ListTile(
            title: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Course',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 80,
                        child: TextField(
                          controller: creditController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Credits',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedGrades[index],
                            items: <String>[
                              'A+',
                              'A',
                              'A-',
                              'B+',
                              'B',
                              'B-',
                              'C+',
                              'C',
                              'C-',
                              'D',
                              'F'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGrades[index] = newValue!;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill out all the spaces"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ...containers,
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 8),
            child: ElevatedButton(
              onPressed: () {
                double? gpa = calculateGPA();
                if (gpa == null) {
                  showErrorDialog("Please fill in all fields correctly before calculating.");
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Calculated GPA"),
                        content: Text("Your GPA is: ${gpa.toStringAsFixed(2)}"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(

                                
                              );
                            },
                            child: const Text("OK"),
// so Abdella what we are going to do now is when we press ok this the above it must send the result to the home screen that we provided

                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                'Calculate',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
