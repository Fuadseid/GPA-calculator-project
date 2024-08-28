import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gpa_calculator/main.dart';
import 'package:gpa_calculator/screen/gpa_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'lib/assets/OIP.jpg',
              ),
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
