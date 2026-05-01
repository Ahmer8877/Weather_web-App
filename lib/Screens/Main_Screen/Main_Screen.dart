import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_web/Screens/Home_Screen/Home_Screen.dart';
import 'package:weather_web/Screens/Search_Screen/Search_Screen.dart';
import 'package:weather_web/Screens/widgets/bottomNavigationBar_widget/Bar_widget.dart';
import 'package:weather_web/data/providers/currentIndex_provider/index_provider.dart';
import '../Forcast_Screen/Cast_Screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

List<String> screeNames=['HOME','SEARCH','FORCAST'];
List<Widget> widgets=[HomeScreen(),SearchScreen(),Forcast_Screen()];

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {

    final indexProvider = context.watch<IndexProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(screeNames[indexProvider.currentIndex],
          style: TextStyle(fontFamily: 'first',fontWeight: FontWeight.bold,color: Colors.blueAccent),),
        centerTitle: true,
        leading: Padding(padding: EdgeInsets.symmetric(horizontal: 5),
          child: Image.asset('assets/logo/weather.png',height: 25,width: 25,),),
        actions: [
          //popUpMenu Button
          PopupMenuButton(
              itemBuilder: (context)=>[
                PopupMenuItem(
                  onTap: (){
                    context.goNamed('setting');
                  },
                    child:Row(children: [Text('Settings'),Icon(Icons.settings)],)
                )
              ]
          )
        ],
      ),

      //bottom navigation in separate widgets
      bottomNavigationBar: BarWidget(),

      //main app screen body

      body: widgets[indexProvider.currentIndex],
    );
  }
}
