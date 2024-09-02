import 'package:flutter/material.dart';

class AboutUsDetail extends StatefulWidget {
  AboutUsDetail({super.key, required this.title, required this.image});
  String title;
  final image;

  @override
  State<AboutUsDetail> createState() => _AboutUsDetailState();
}

class _AboutUsDetailState extends State<AboutUsDetail> {
  @override
  Widget build(BuildContext context) {
    final image = widget.image;
    final name = widget.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.all(16),
                width: 400,
                height: 400,
                child: image),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'My name is ${name}, and I am a dedicated software engineering student at Debre Birhan University. As I pursue my academic goals, I am also actively seeking employment opportunities in the tech industry. I possess a strong foundation in both front-end and back-end development, specializing in creating dynamic and responsive web applications. My skills extend to mobile app development using Flutter, enabling me to build high-quality applications for both iOS and Android platforms. Additionally, I am proficient in the React.js library, which allows me to develop engaging user interfaces with seamless functionality. I am eager to contribute my skills and collaborate with innovative teams to make a positive impact in the field of technology.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }
}
