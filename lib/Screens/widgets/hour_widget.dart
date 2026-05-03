import 'package:flutter/material.dart';
import 'package:weather_web/data/models/My_Response_Models/hour_model.dart';

class HourWidget extends StatelessWidget {
  final Hour hour;

  const HourWidget({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {

    //Every day separate widget
    return  Container(
      width: 60,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(hour.condition?.icon??''),
          Text(hour.time??'',
              style:  TextStyle(color: Colors.white38, fontSize: 10)),
          Text('${hour.tempC.toString()}°',
              style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}
