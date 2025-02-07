import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zynerd/SettingsPage/Settings.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List data = [];
  final TextEditingController _searchController = TextEditingController();
  final List<String> locations = [
    "Chennai",
    "Tiruchirapalli",
    "Coimbatore",
    "Karur",
    "Namakkal",
    "Salem",
    "Theni",
    "Vellore",
  ];
  bool _isSearching = false;

  Future<void> getData() async{
    final res = await http.get(Uri.parse("https://api.weatherapi.com/v1/current.json?key=bdb504e98ef54d49a1760256242412&q=Coimbatore"));
    print("Api Called");
    if(res.statusCode == 200){
      print(res.body.toString());
    }
    setState(() {
      data = jsonDecode(res.body.toString())['data'];
    });
  }

  void iniState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(

      backgroundColor: Colors.blue,

      body: SafeArea(

          child: Column(
            children: [

              Container(
                width: 341,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.blue,
                ),
                margin: EdgeInsets.all(10),

                child: Padding(
                  padding: EdgeInsets.all(10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Call Api TIME
                              Text(
                                // data[index]['localtime'],
                                "22.15",
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),

                              // Call Api DATE
                              Text(
                                // data[index]['localtime'],
                                "07-02-2025",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),

                            ],
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context)=> SettingsPage(),
                                ),);
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 50,
                        width: 342,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Padding(
                              padding: EdgeInsets.all(8.0),

                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),

                                // search bar popup
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isSearching = !_isSearching;
                                    });
                                  },

                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 3, 2, 3),
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      "Search ...",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),

                                ),

                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(8.0),

                              child: Stack(
                                children: [

                                  Container(
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(60),
                                      color: Color(0xff2E6DFE),
                                    ),
                                    child: IconButton(
                                      alignment: Alignment.topCenter,
                                      onPressed: () {
                                        setState(() {
                                          _isSearching = true;
                                        });
                                      }, //search bar popup
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                    ),

                                  ),

                                  if (_isSearching)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: locations.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: Icon(Icons.search, color: Colors.black54),
                                          title: Text(
                                            locations[index],
                                            style: TextStyle(color: Colors.black87, fontSize: 16),
                                          ),
                                          onTap: () {
                                            print("Selected: ${locations[index]}");
                                            _searchController.text = locations[index]; // Update text field
                                            setState(() {
                                              _isSearching = false; // Hide results after selection
                                            });
                                          },
                                        );
                                      },
                                    ),

                                ],
                              )

                            ),

                          ],
                        ),

                      ),

                    ],
                  ),

                ),

              ),

              SizedBox(
                height: 20,
              ),

              Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  children: [

                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),

                                    SizedBox(
                                      width: 5,
                                    ),

                                    // Call API Location name
                                    Text(
                                      "Coimbatore",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                  ],
                                ),

                                // Call API Location name
                                Text(
                                  "Coimbatore, Tamil Nadu",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),

                              ],
                            ),

                            Column(
                              children: [

                                Text(
                                  "21°C", //call degree from api
                                  style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),

                                Text(
                                  "Mist", //call Climate from api
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white70,
                                  ),
                                ),

                              ],
                            ),

                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),

                          child: Container(
                            height: 32,
                            width: 294,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                            ),

                            padding: EdgeInsets.symmetric(horizontal: 13),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    Icon(
                                      Icons.thermostat,
                                      color: Color(0xff2E6DFE),
                                    ),

                                    SizedBox(
                                      width: 5,
                                    ),

                                    Text(
                                      "Feels Like",
                                      style: TextStyle(
                                          color: Color(0xff2E6DFE),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                  ],
                                ),

                                Text(
                                  "19°C", //call degree from api
                                  style: TextStyle(
                                      color: Color(0xff2E6DFE),
                                      fontSize: 16
                                  ),
                                ),

                              ],
                            ),

                          ),

                        ),

                        GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.0,
                          ),
                          children: [

                            weatherInfo("Humidity", "50%"),
                            weatherInfo("WindChill", "2C"),
                            weatherInfo("UV Index", "4/10"),
                            weatherInfo("Pressure", "4/10"),
                            weatherInfo("Heat Index", "5"),
                            weatherInfo("Dew Points", "7"),

                          ],
                        ),

                      ],
                    ),

                  ),

            ],
          ),

      ),

    );
  }

  Widget weatherInfo(String title, String value) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),

          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }

}

