import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'package:weather_web/data/providers/Home_provider/home_provider.dart';
import 'package:weather_web/data/providers/currentIndex_provider/index_provider.dart';
import 'package:weather_web/data/providers/search_provider/search_provider.dart';
import 'package:weather_web/data/repositories/weather_repo.dart';
import 'package:weather_web/data/source_api/weather_Api.dart';
import 'package:weather_web/utils/go_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'data/providers/Forcast_provider/Forcast_provider.dart';
import 'data/providers/weatherDetail_provider/weatherDetail_provider.dart';

//global key for use in  (ScaffoldMessengerState)

GlobalKey<ScaffoldMessengerState> scaffoldMessenger=GlobalKey<ScaffoldMessengerState>();

//main function
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
  runApp(const weather_web());
}
class weather_web extends StatelessWidget {
  const weather_web({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context)=>WeatherApi()),
          Provider(create: (context)=>WeatherRepo(context.read<WeatherApi>())),
          ChangeNotifierProvider(create: (context)=> HomeProvider(context.read<WeatherRepo>())),
          ChangeNotifierProvider(create: (context)=> ForcastProvider(context.read<WeatherRepo>())),
          ChangeNotifierProvider(create: (context)=> SearchProvider(context.read<WeatherRepo>())),
          ChangeNotifierProvider(create: (context)=> WeatherdetailProvider(context.read<WeatherRepo>())),
          ChangeNotifierProvider(create: (context)=> IndexProvider()),
        ],
      //MaterialApp with routes
      child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessenger,
      routerConfig: GoRoutes.routes(),
    ),
    );
  }
}
