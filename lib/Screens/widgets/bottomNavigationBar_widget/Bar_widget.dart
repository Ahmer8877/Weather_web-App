import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/currentIndex_provider/index_provider.dart';

class BarWidget extends StatelessWidget {
  const BarWidget({super.key});

  @override
  Widget build(BuildContext context) {
     final indexProvider=context.watch<IndexProvider>();

     //separate bottom navigation widget

    return  Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                  backgroundColor: const Color(0xFF0B1535),
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.white38,
            iconSize: 30,
            onTap: (value){
              indexProvider.index=value;
            },
            currentIndex: indexProvider.currentIndex,
                  // items
            items: [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: 'Search'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.info),label: 'Forcast'),
            ]
        ),
      ),
    );
  }
}
