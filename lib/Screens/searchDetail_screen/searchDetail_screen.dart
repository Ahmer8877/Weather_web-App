import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_web/data/models/My_Response_Models/Search_model.dart';
import 'package:weather_web/data/providers/weatherDetail_provider/weatherDetail_provider.dart';

class SearchdetailScreen extends StatefulWidget {
  //items model required
  final search_model item;
  const SearchdetailScreen({super.key, required this.item});

  @override
  State<SearchdetailScreen> createState() => _SearchdetailScreenState();
}

class _SearchdetailScreenState extends State<SearchdetailScreen> {

  //init state func.
  @override
  void initState() {
    context.read<WeatherdetailProvider>().getCurrentWeather(widget.item.name??'');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    //initialize provider with consumer

    return Consumer<WeatherdetailProvider>(
        builder: (context,provider,child) {
          // Skeletonizer is loading state
          return Skeletonizer(
            enabled: provider.isLoading,

            //main root of screen
            child: Scaffold(
              backgroundColor: const Color(0xFF0B1535),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      // HEADER SECTION
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [

                            // Location Row
                            Row(
                              children: [
                                IconButton(onPressed: (){context.pop();}, icon: Icon(Icons.arrow_back,color: Colors.white,)),

                                Icon(Icons.location_on, color: Colors.blue),
                                const SizedBox(width: 5),
                                Text(provider.location?.name?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children:  [
                                    Text(provider.location?.region?? '',
                                        style: TextStyle(color: Colors.white70)),
                                    Text(provider.location?.country?? '',
                                        style: TextStyle(color: Colors.white38)),
                                  ],
                                )
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Temperature Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    Text(provider.current?.tempC.toString()?? '',
                                        style: TextStyle(
                                            fontSize: 70,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                    Text("°C",
                                        style: TextStyle(color: Colors.white54)),
                                  ],
                                ),
                                Column(
                                  children:  [
                                    Image.network(provider.current?.condition?.icon?.replaceFirst('//', 'http://')?? '',
                                    ),
                                    SizedBox(height: 5),
                                    Text(provider.current?.condition?.text?? '',
                                        style: TextStyle(color: Colors.white70)),
                                  ],
                                )
                              ],
                            ),

                            const SizedBox(height: 15),

                            // Feels Like Row
                            Row(
                              children: [
                                expandedCard("Feels Like", '${provider.current?.feelslikeC?? ''}°C'),
                                expandedCard("Humidity", '${provider.current?.humidity ?? ''}%'),
                                expandedCard("Cloud", '${provider.current?.cloud?? ''}%'),
                              ],
                            )
                          ],
                        ),
                      ),

                      divider(),

                      // WIND SECTION
                      sectionTitle("WIND"),
                      cardBox(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text("Speed: ${provider.current?.windKph?? ''}Kph",
                                style: TextStyle(color: Colors.white)),
                            Text("Direction: ${provider.current?.windDir?? ''}",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),

                      divider(),

                      //  ATMOSPHERE GRID
                      sectionTitle("ATMOSPHERE"),
                      gridSection([
                        gridItem("Pressure", "${provider.current?.pressureMb?? ''}mb"),
                        gridItem("Precipitation", "${provider.current?.precipMm?? ''}mm"),
                        gridItem("Visibility", "${provider.current?.visKm?? ''}km"),
                        gridItem("UV Index", provider.current?.uv.toString()?? ''),
                      ]),

                      divider(),

                      // THERMAL
                      sectionTitle("THERMAL"),
                      gridSection([
                        gridItem("Windchill", "${provider.current?.windDegree?? ''}°C"),
                        gridItem("Heat Index", "${provider.current?.heatindexC?? ''}°C"),
                        gridItem("Dewpoint", "${provider.current?.dewpointC?? ''}°C"),
                        gridItem("Temp °F", "${provider.current?.tempF}°F"),
                      ]),

                      divider(),

                      //  SOLAR
                      sectionTitle("SOLAR"),
                      gridSection([
                        gridItem("Short Rad", provider.current?.shortRad.toString()??''),
                        gridItem("Diffuse Rad", provider.current?.diffRad.toString()??''),
                        gridItem("DNI", provider.current?.dni.toString()??''),
                        gridItem("GTI", provider.current?.gti.toString()??''),
                      ]),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

//Extra widgets

//expandedCard widget
Widget expandedCard(String title, String value) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
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
    ),
  );
}

//gridItem widget

Widget gridItem(String title, String value) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF111E3E),
      borderRadius: BorderRadius.circular(10),
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

//gridSection widget

Widget gridSection(List<Widget> items) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: items,
    ),
  );
}

//sectionTitle widget

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

//divider widget

Widget divider() {
  return Container(
    height: 1,
    color: Colors.white12,
    margin: const EdgeInsets.symmetric(vertical: 10),
  );
}

//cardBox widget

Widget cardBox(Widget child) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF111E3E),
      borderRadius: BorderRadius.circular(10),
    ),
    child: child,
  );
}
