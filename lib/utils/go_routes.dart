import 'package:go_router/go_router.dart';
import 'package:weather_web/Screens/Main_Screen/Main_Screen.dart';
import 'package:weather_web/Screens/Splash_Screen/Splash_Screen.dart';
import 'package:weather_web/Screens/searchDetail_screen/searchDetail_screen.dart';
import 'package:weather_web/Screens/setting_screen/setting_sreen.dart';
import 'package:weather_web/data/models/My_Response_Models/Search_model.dart';

//GoRoutes class

class GoRoutes {

  //All routers(screen)
  static GoRouter routes() => GoRouter(
      routes: [
        //splash screen
        GoRoute(path: '/',builder: (context,state) =>SplashScreen(),),
        //main screen
        GoRoute(path: '/main',name: 'main',builder: (context,state)=>MainScreen(),
          routes: [
            //setting screen
            GoRoute(path: '/setting',name: 'setting',builder: (context,state)=>SettingSreen()),
            //weather detail screen with extra parameter
            GoRoute(path: '/weather',name: 'weather',builder: (context,state)=>SearchdetailScreen(item: state.extra as search_model)),
          ]
        )
      ],
  );
}