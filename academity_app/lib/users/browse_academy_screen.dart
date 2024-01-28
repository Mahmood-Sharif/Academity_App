import 'package:flutter/material.dart';
import 'package:academity_app/api_connection/api_service.dart';

class BrowseAcademyScreen extends StatelessWidget {
  final String sportId;
  final String sportName;
  final ApiService api = ApiService();

  BrowseAcademyScreen(
      {Key? key, required this.sportId, required this.sportName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academies for $sportName'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: api.fetchAcademies(sportId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var academy = snapshot.data![index];
                var baseUrl = 'http://192.168.28.119/';
                var imageUrl = '$baseUrl${academy['image_url']}';
                return ListTile(
                  leading: Image.network(imageUrl, fit: BoxFit.cover),
                  title: Text(academy['name']),
                  subtitle: Text(academy['location']),
                );
              },
            );
          } else {
            return Center(child: Text("No academies found for $sportName"));
          }
        },
      ),
    );
  }
}
