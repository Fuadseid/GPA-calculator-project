import 'package:flutter/material.dart';
import 'package:gpa_calculator/screen/gpa_form_screen.dart';
import 'package:gpa_calculator/widget/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  HomeScreen(
      {super.key,
      required this.gpa,
      required this.credits,
      required this.onDarkMode,
      required this.isDarkMode});
  final double gpa;
  final double credits;
  void Function() onDarkMode;
  bool isDarkMode;

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

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _numberofCourseController.dispose();
    _animationcontroller.dispose();
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

    List<Color> cont = [
      const Color.fromARGB(255, 33, 243, 198),
      const Color.fromARGB(255, 7, 123, 98)
    ];
    List<Color> darcolor = [
      const Color.fromARGB(255, 37, 40, 40),
      const Color.fromARGB(96, 64, 60, 60)
    ];

    void bottom_up() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 400,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _numberofCourseController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Number of course',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 55,
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: widget.isDarkMode ? darcolor : cont),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (_numberofCourseController.text.isEmpty ||
                                double.tryParse(
                                        _numberofCourseController.text) ==
                                    null) {
                              showErrorDialog(
                                  "Please fill The Number of The Course.");
                            } else {
                              _addFormScreen();
                            }
                          },
                          child: Text(
                            'Okay',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    var creditHr = widget.credits;
    var gpa = widget.gpa;
    var darkech = widget.isDarkMode;
    final temp = cont;

    Widget? hold = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: darkech ? darcolor : cont)),
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
    if (gpa >= 3.0) {
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
    } else if (gpa >= 2.5 && gpa < 3.0) {
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
          backgroundColor: widget.isDarkMode
              ? const Color.fromARGB(168, 42, 18, 53)
              : Theme.of(context).colorScheme.onTertiary,
          title: Text(
            "GPA Calculator App",
            style: widget.isDarkMode
                ? TextStyle(color: Colors.white)
                : Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(13),
              child: IconButton(
                onPressed: widget.onDarkMode, // Call the toggle method
                icon: widget.isDarkMode
                    ? const Icon(Icons.brightness_2)
                    : const Icon(Icons.brightness_1),
              ),
            ),
          ],
        ),
        drawer: Drawers(), // Ensure you have a Drawers widget defined
        body: SingleChildScrollView(
          child: Container(
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
                        minimumSize: MaterialStateProperty.all(
                            Size(double.infinity, 50)),
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
        ) // Ensure you have a HomeScreen widget defined
        );
  }
}
