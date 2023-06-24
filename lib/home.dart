import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:planty/plant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:tflite/tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ph = "", nitrogen = "", phosphrous = "", potassium = "", city = "";
  TextEditingController _locationController = TextEditingController();
  double temperature = 0.0;
  int humidity = 0;
  double windSpeed = 0;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      'assets/bg.jpg',
                    ),
                    fit: BoxFit.cover,
                  )),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height * 0.4,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Card(
                      color: Color.fromARGB(194, 253, 252, 252),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "planT",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.065,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.height *
                                        0.7,
                                    height: MediaQuery.of(context).size.height *
                                        0.075,
                                    child: TextField(
                                      controller: _locationController,
                                      decoration: const InputDecoration(
                                        labelText: 'Location',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.height *
                                      0.006,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.1,
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      fetchLocation();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    child: Text(
                                      'Fetch',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.0225,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height * 0.7,
                              height: MediaQuery.of(context).size.height * 0.06,
                              color: Colors.white,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  labelText: "pH",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "City cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  ph = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height * 0.7,
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              color: Colors.white,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  labelText: "Nitrogen",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Nitrogen cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  nitrogen = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height * 0.7,
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              color: Colors.white,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  labelText: "Phosphrous",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Phosphrous cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  phosphrous = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height * 0.7,
                              height: MediaQuery.of(context).size.height * 0.06,
                              color: Colors.white,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  labelText: "Potassium",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Potassium cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  potassium = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.4,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await fetchWeatherData(
                                        _locationController.text);
                                    formKey.currentState!.reset();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Text(
                              'Temperature: ${temperature.toStringAsFixed(1)}°C',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              'Humidity: $humidity%',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              'Wind Speed: $windSpeed km/h',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void fetchLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    _locationController.text = '${placemark.locality}';
  }

  Future<void> fetchWeatherData(String city) async {
    print(city + "--------------------------");
    String apiKey = 'ee1ad8e884410c46aaf6bd39d68a969a';
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        print(data['main']['humidity'].toString() +
            "--------------------------------------");
        setState(() {
          temperature = data['main']['temp'];
          humidity = data['main']['humidity'];
          windSpeed = data['wind']['speed'];
        });
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      print(e);
    }
  }

  late Interpreter interpreter;

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/your_model.tflite');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  void predictCrop() async {
    double inputPh = double.parse(ph);
    double inputNitrogen = double.parse(nitrogen);
    double inputPhosphorus = double.parse(phosphrous);
    double inputPotassium = double.parse(potassium);
    double inputTemp = temperature;
    double inputHumidity = humidity as double;
    double inputWindspeed = windSpeed;

    const int numClasses = 1;

    List inputData = [
      inputPh,
      inputNitrogen,
      inputPhosphorus,
      inputPotassium,
      inputTemp,
      inputHumidity,
      inputWindspeed
    ];

    var input = inputData.reshape([1, 7]);
    var output =
        List<double>.filled(1 * numClasses, 0).reshape([1, numClasses]);

    interpreter.run(input, output);
    var cropIndex = output;

    //String cropName = Plant.getCropNameFromIndex(output[0]);
    //setState(() {
    //predictedCrop = cropName;
    //});
  }
}

@override
void dispose() {
  Tflite.close();
}
