import 'package:flutter/material.dart';

class GpaFormScreen extends StatefulWidget {
  GpaFormScreen({
    super.key,
    required this.enterednumber,
  });
  final enterednumber;
  @override
  State<GpaFormScreen> createState() {
    return _GpaFormScreen();
  }
}

class _GpaFormScreen extends State<GpaFormScreen> {
  @override
  Widget build(BuildContext context) {
    var number = int.parse(widget.enterednumber.text);

    Widget? content;
    List<Widget> containers = [];

    if (number > 0) {
      for (var x = 0; x < number; x++) {
        containers.add(
          Expanded(
            child: Container(
              width: 300,
              height: 200,
              child: Expanded(
                child: Column(
                  children: [(Text("form ${x + 1}"))],
                ),
              ),
            ),
          ),
        );
      }

      return content = Column(children: containers);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill out all the spaces "),
      ),
      body: Expanded(child: ListView(children: containers)),
    );
  }
}
