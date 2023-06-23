import 'package:flutter/material.dart';

class Plant extends StatefulWidget {
  final String city, ph, nh, water;

  const Plant(
      {super.key,
      required this.city,
      required this.ph,
      required this.nh,
      required this.water});

  @override
  State<Plant> createState() => _PlantState();
}

class _PlantState extends State<Plant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Card(
            elevation: 15.0,
            child: Column(children: [
              Text(widget.city),
              Text(widget.ph),
              Text(widget.nh),
              Text(widget.water)
            ]),
          ),
        ),
      ),
    );
  }
}
