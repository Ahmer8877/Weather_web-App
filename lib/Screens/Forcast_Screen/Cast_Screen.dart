import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_web/Screens/widgets/hour_widget.dart';
import 'package:weather_web/data/providers/Home_provider/home_provider.dart';
import '../../data/providers/Forcast_provider/Forcast_provider.dart';

class Forcast_Screen extends StatefulWidget {

  const Forcast_Screen({super.key});

  @override
  State<Forcast_Screen> createState() => _Forcast_ScreenState();
}

class _Forcast_ScreenState extends State<Forcast_Screen> {

  @override
  Widget build(BuildContext context) {

     final  forCastProvider=context.watch<ForcastProvider>();
     final  homeProvider=context.watch<HomeProvider>();

    return Skeletonizer(
      enabled: forCastProvider.isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1535),
        body: SafeArea(
          child:ListView(
            children: [

             // for loop

              for(var forecast in forCastProvider.forecastList)
          Column(
          children: [
              //  TOP BAR
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Forecast",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text("3-DAY FORECAST",
                      style: TextStyle(color: Colors.white38, fontSize: 10)),
                ],
              ),
            ],
          ),
                  ),

                  // DAY TABS
                  SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [

              dayTab("TODAY", "${forecast.day?.avgtempC}°", true),
            ],
          ),
                  ),

                  // DAY SUMMARY
                  sectionTitle("DAY"),
                  card(
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${forecast.day?.maxtempC}°C",
                          style: TextStyle(
                              fontSize: 34,
                              color: Colors.white)),
                      Text("Max Temp",
                          style: TextStyle(color: Colors.white38)),
                      SizedBox(height: 5),
                      Text("↓ ${forecast.day?.maxtempC}°C   ~ ${forecast.day?.mintempC}°",
                          style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                  Image.network('${homeProvider.current?.condition?.icon}')
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  pill("Humidity", "${forecast.day?.avghumidity}%"),
                  pill("Visibility", "${forecast.day?.avgvisKm} km"),
                  pill("UV", forecast.day?.uv.toString()??''),
                  pill("Snow", "${forecast.day?.totalsnowCm} cm"),
                ],
              )
            ],
          ),
                  ),

                  //  WIND
                  sectionTitle("WIND"),
                  Row(
          children: [
            Expanded(child: infoCard("Max Wind", "${forecast.day?.maxwindKph} kph")),
            Expanded(child: infoCard("Precip", "${forecast.day?.totalprecipMm} mm")),
          ],
                  ),

                  // CHANCE
                  sectionTitle("PRECIPITATION"),
                  Row(
          children: [
            Expanded(child: progressCard("Rain", '${forecast.day?.dailyChanceOfRain}')),
            Expanded(child: progressCard("Snow", '${forecast.day?.dailyChanceOfRain}')),
          ],
                  ),

                  //  HOURLY
                  sectionTitle("HOURLY"),
                  SizedBox(
          height: 120,
          child: Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for(var hour in forecast.hour??[])
                HourWidget( hour: hour)
              ],
            ),
          ),
                  ),

                  //  SUN
                  sectionTitle("SUN"),
                  Row(
          children: [
            Expanded(child: infoCard("Sunrise", "${forecast.astro?.sunrise}")),
            Expanded(child: infoCard("Sunset", "${forecast.astro?.sunset}")),
          ],
                  ),

                  // MOON
                  sectionTitle("MOON"),
                  card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text("Waxing Crescent",
                  style: TextStyle(color: Colors.orange)),
              SizedBox(height: 5),
              Text("Illumination: ${forecast.astro?.moonIllumination}%",
                  style: TextStyle(color: Colors.white38)),
              SizedBox(height: 5),
              Text("Rise: ${forecast.astro?.moonrise}   ${forecast.astro?.moonset} ",
                  style: TextStyle(color: Colors.white54)),
            ],
          ),
                  ),

                  const SizedBox(height: 20),
                  ],
                ),
    ]
          ),
    )
    )
    );
  }
}

Widget dayTab(String day, String temp, bool active) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: active ? const Color(0xFF185FA5) : const Color(0xFF111E3E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(day, style: const TextStyle(color: Colors.white38)),
        Text(temp,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    ),
  );
}

Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: const TextStyle(color: Colors.white38, fontSize: 12)),
    ),
  );
}

Widget card(Widget child) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF111E3E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  );
}

Widget pill(String title, String value) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white38, fontSize: 9)),
          Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    ),
  );
}

Widget infoCard(String title, String value) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF111E3E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(title,
            style: const TextStyle(color: Colors.white38, fontSize: 10)),
        const SizedBox(height: 5),
        Text(value,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    ),
  );
}

Widget progressCard(String title, String percent) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF111E3E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white38)),
        const SizedBox(height: 5),
        Text("$percent%",
            style: const TextStyle(color: Colors.blue, fontSize: 18)),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          backgroundColor: Colors.white10,
          color: Colors.blue,
        ),
      ],
    ),
  );
}
