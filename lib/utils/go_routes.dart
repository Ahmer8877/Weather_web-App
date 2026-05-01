import 'package:go_router/go_router.dart';
import 'package:weather_web/Screens/Main_Screen/Main_Screen.dart';
import 'package:weather_web/Screens/Splash_Screen/Splash_Screen.dart';
import 'package:weather_web/Screens/searchDetail_screen/searchDetail_screen.dart';
import 'package:weather_web/Screens/setting_screen/setting_sreen.dart';
import 'package:weather_web/data/models/My_Response_Models/Search_model.dart';

class GoRoutes {

  static GoRouter routes() => GoRouter(
      routes: [
        GoRoute(path: '/',builder: (context,state) =>SplashScreen(),),
        GoRoute(path: '/main',name: 'main',builder: (context,state)=>MainScreen(),
          routes: [
            GoRoute(path: '/setting',name: 'setting',builder: (context,state)=>SettingSreen()),
            GoRoute(path: '/weather',name: 'weather',builder: (context,state)=>SearchdetailScreen(item: state.extra as search_model)),
          ]
        )
      ],
  );
}