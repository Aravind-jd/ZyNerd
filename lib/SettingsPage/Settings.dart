import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final TextEditingController _searchController = TextEditingController();

  List<String> allCities = [
    "Chennai",
    "Tiruchirapalli",
    "Coimbatore",
    "Karur",
    "Namakkal",
    "Salem",
    "Theni",
    "Vellore"
  ];

  List<String> searchResults = [];

  bool showHistory = false;
  bool isCelsius = true; // Default in celsius

  @override
  void initState() {
    super.initState();
  }

  void _filterSearchResults(String query) {
    setState(() {
      searchResults = allCities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
      showHistory = query.isNotEmpty; // Show results only when searched
    });
  }

  void _deleteItem(String city) {
    setState(() {
      searchResults.remove(city);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 40), // Space for status bar
            _buildToggleSwitch(),

            SizedBox(
                height: 20
            ),

            SizedBox(
                height: 20
            ),

            Text(
              "History",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            SizedBox(
                height: 10
            ),

            _buildSearchResults(),

          ],
        ),

      ),

    );
  }

  Widget _buildToggleSwitch() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton("Celsius", isCelsius),
          _buildToggleButton("Fahrenheit", !isCelsius),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCelsius = (text == "Celsius");
        });
      },
      child: Container(
        width: 178,
        height: 42,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }


  Widget _buildSearchResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
                Icons.youtube_searched_for_rounded,
                color: Colors.black54
            ),
            title: Text(
                searchResults[index]
            ),
            trailing: IconButton(
              icon: Icon(
                  Icons.delete,
                  color: Colors.red
              ),
              onPressed: () => _deleteItem(
                  searchResults[index]
              ),
            ),
          );
        },
      ),
    );
  }

}
