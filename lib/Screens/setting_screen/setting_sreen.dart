import 'package:flutter/material.dart';

class SettingSreen extends StatelessWidget {
  const SettingSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //app bar
      appBar: AppBar(
        title: Row(children: [Icon(Icons.settings),Text('Setting')],),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('About'),
                subtitle: Text('version 1.0'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
