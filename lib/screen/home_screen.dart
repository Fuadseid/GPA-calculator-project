import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
         Padding(padding:const  EdgeInsets.all(13), child:IconButton(onPressed: (){}, icon: Icon(Icons.sunny))),
        ],
      ),

      body: Container(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network('https://th.bing.com/th/id/OIP.7uuO9-uFJ5lGG-_PgDyv7wHaES?rs=1&pid=ImgDetMain'),
              
          OutlinedButton(onPressed: (){}, child: const  Text('start      ➡️', style: TextStyle(color:Color.fromARGB(255, 117, 230, 121) ),), )

          ],
      ),
    )
    );
  }
}
