import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:planty/plant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String city = "", ph = "", nh = "", water = "";
  TextEditingController _locationController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Form(
            key: formKey,
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
                  height: MediaQuery.of(context).size.height * 0.65,
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
                                  width:
                                      MediaQuery.of(context).size.height * 0.7,
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
                                width:
                                    MediaQuery.of(context).size.height * 0.006,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.height * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
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
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                labelText: "City",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "City cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                city = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.height * 0.7,
                            height: MediaQuery.of(context).size.height * 0.055,
                            color: Colors.white,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                labelText: "ph",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "ph cannot be empty";
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
                            height: MediaQuery.of(context).size.height * 0.055,
                            color: Colors.white,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                labelText: "nh",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "nh cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                nh = value;
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
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                labelText: "water content",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "water content cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                water = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 0.7,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Plant(
                                        city: city,
                                        ph: ph,
                                        nh: nh,
                                        water: water,
                                      ),
                                    ),
                                  );
                                }
                              },
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
    );
  }

  void fetchLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _locationController.text =
          'Lat: ${position.latitude}, Lng: ${position.longitude}';
    });
  }
}
