import 'package:flutter/material.dart';
import 'package:gpa_calculator/screen/about_us_detail.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const title1 = 'Abdelah Nesredin';
    const title2 = 'Fuad Seid';
    Widget photo1 = Image.asset(
      'lib/assets/Abdellah.jpg',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
    Widget photo2 = Image.asset(
      'lib/assets/Fuad.jpg',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('About The Developer'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutUsDetail(
                        title: title1,
                        image: photo1,
                      )));
            },
            child: Card(
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'lib/assets/Abdellah.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                 const Text(title1),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutUsDetail(
                        title: title2,
                        image: photo2,
                      )));
            },
            child: Card(
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'lib/assets/Fuad.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(title2),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
