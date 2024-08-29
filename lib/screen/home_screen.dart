import 'package:flutter/material.dart';
import 'package:gpa_calculator/screen/gpa_form_screen.dart';
import 'package:gpa_calculator/widget/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.gpa, required this.credits});
  final double gpa;
  final double credits;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _numberofCourseController = TextEditingController();
  late AnimationController _animationcontroller; // Move here

  @override
  void initState() {
    super.initState();
    _animationcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animationcontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationcontroller.forward(from: 0);
      }
    });

    _animationcontroller.addListener(() {
      setState(() {});
    });

    _animationcontroller.forward();
  }

  @override
  void dispose() {
    _numberofCourseController.dispose();
    _animationcontroller.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _addFormScreen() {
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            GpaFormScreen(enterednumber: _numberofCourseController),
      ));
    }

    void bottom_up() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 400,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _numberofCourseController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Number of course',
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _addFormScreen,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                      child: Text(
                        'Okay',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    var creditHr = widget.credits;
    var gpa = widget.gpa;

    Widget? hold = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                height: 350,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 155, 245, 226),
                          Color.fromARGB(255, 49, 227, 189)
                        ])),
                child: Column(
                  children: [
                    const Text(
                      'GPA Grading System:\n A: 4.0, A: 4.0, A-: 3.75,\n B+: 3.25, B: 3.0, B-: 2.75,\n C+: 2.5, C: 2.0, C-: 1.5,\n D: 1.0,\n F: 0.0, \nIt is Based on DebreBirhan University Grading System.',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse('https://www.dbu.edu.et');
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch ${url}');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: const Text(
                          ' For More Click ⬇️\n Debre Berhan University',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 12, 27, 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Widget? content1;
    if (gpa > 3.0) {
      content1 = Center(
        child: Container(
          width: 400,
          height: 200,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: SweepGradient(
              startAngle: 4,
              colors: const [
                Color.fromARGB(255, 2, 243, 10),
                Color.fromARGB(255, 72, 97, 72),
              ],
              transform: GradientRotation(_animationcontroller.value * 2 * pi),
            ),
          ),
          child: Container(
            width: 400,
            height: 300,
            decoration: const BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color.fromARGB(255, 255, 255, 255)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Credits: $creditHr',
                  style: const TextStyle(
                      fontSize: 24, color: Color.fromARGB(255, 21, 1, 1)),
                ),
                const SizedBox(height: 5),
                Text(
                  'GPA: ${gpa.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 24, color: const Color.fromARGB(255, 21, 1, 1)),
                ),
                const Text(
                  '👏',
                  style: const TextStyle(
                      fontSize: 24, color: const Color.fromARGB(255, 21, 1, 1)),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (gpa > 2.5 && gpa < 3.0) {
      content1 = Center(
        child: Container(
          width: 400,
          height: 200,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gradient: SweepGradient(
              startAngle: 4,
              colors: const [
                Color.fromARGB(255, 215, 243, 2),
                Color.fromARGB(255, 93, 97, 72),
              ],
              transform: GradientRotation(_animationcontroller.value * 2 * pi),
            ),
          ),
          child: Container(
            width: 400,
            height: 300,
            decoration: const BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Credits: $creditHr',
                  style: const TextStyle(
                      fontSize: 24, color: Color.fromARGB(255, 21, 1, 1)),
                ),
                const SizedBox(height: 5),
                Text(
                  'GPA: ${gpa.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 24, color: const Color.fromARGB(255, 21, 1, 1)),
                ),
                const Text(
                  '👍',
                  style: const TextStyle(
                      fontSize: 24, color: const Color.fromARGB(255, 21, 1, 1)),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (gpa <= 2.5) {
      content1 = Center(
        child: Container(
          width: 400,
          height: 200,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gradient: SweepGradient(
              startAngle: 4,
              colors: const [
                Color.fromARGB(255, 243, 2, 2),
                Color.fromARGB(255, 97, 72, 72),
              ],
              transform: GradientRotation(_animationcontroller.value * 2 * pi),
            ),
          ),
          child: Container(
            width: 400,
            height: 300,
            decoration: const BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color.fromARGB(255, 255, 255, 255)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Credits: $creditHr',
                  style: const TextStyle(
                      fontSize: 24, color: Color.fromARGB(255, 21, 1, 1)),
                ),
                const SizedBox(height: 5),
                Text(
                  'GPA: ${gpa.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 24, color: const Color.fromARGB(255, 21, 1, 1)),
                ),
                const Text(
                  '📛',
                  style: const TextStyle(
                      fontSize: 24, color: const Color.fromARGB(255, 21, 1, 1)),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (creditHr != 0) {
      hold = content1;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onTertiary,
        title: Text(
          "GPA Calculator App",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(13),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sunny),
            ),
          ),
        ],
      ),
      drawer: Drawers(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('lib/assets/OIP.jpg'),
            Container(child: hold),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color.fromARGB(255, 33, 243, 198),
                        const Color.fromARGB(255, 7, 123, 98)
                      ]),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: TextButton(
                  onPressed: bottom_up,
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                  ),
                  child: Text(
                    'Start',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
