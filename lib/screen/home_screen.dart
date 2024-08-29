import 'package:flutter/material.dart';
import 'package:gpa_calculator/screen/gpa_form_screen.dart';
import 'package:gpa_calculator/widget/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.gpa, required this.credits});
  final double gpa;
  final double credits;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _numberofCourseController = TextEditingController();
  @override
  void dispose() {
    _numberofCourseController.dispose();
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
          sheetAnimationStyle: AnimationStyle(),
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
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: _addFormScreen,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context)
                                .colorScheme
                                .primaryContainer), // Set background color
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
              )),
            );
          });
    }

    var creditHr = widget.credits;
    var gpa = widget.gpa;

    Widget hold = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Space between number and description
          Text(
            'GPA Grading System: A: 4.0, A-: 3.75, B+: 3.25, B: 3.0,B-: 2.75,It is Based on DebreBirhan University Grading System ',
            style: TextStyle(fontSize: 20), // Optional: style the description
            textAlign: TextAlign.center, // Center align the text
          ),
          SizedBox(height: 20), // Space between description and link
          GestureDetector(
            onTap: () async {
              const url =
                  'http://www.dbu.edu.et'; // URL for Debre Berhan University
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Text(
              ' For More ➡️ Debre Berhan University',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue, // Link color
                // Underline for link
              ),
            ),
          ),
        ],
      ),
    );
    if (gpa != 0) {
      hold = Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Credits: $creditHr',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'GPA: ${gpa.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onTertiary,
          title: Text(
            "GPA calculator App",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.all(13),
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.sunny))),
          ],
        ),
        drawer: Drawers(),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'lib/assets/OIP.jpg',
              ),
              Container(
                child: hold,
              ), //this container
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: bottom_up,
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 50)),
                    ),
                    child: Text(
                      'Start      ',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
