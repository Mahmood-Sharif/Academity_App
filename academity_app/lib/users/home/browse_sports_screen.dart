import 'package:academity_app/users/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/api_connection/api_service.dart';
import 'browse_academy_screen.dart'; // Make sure to create this screen

class BrowseSportsScreen extends StatefulWidget {
  const BrowseSportsScreen({super.key});

  @override
  _BrowseSportsScreenState createState() => _BrowseSportsScreenState();
}

class _BrowseSportsScreenState extends State<BrowseSportsScreen> {
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Sports'),
      ),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 0),
      body: FutureBuilder<List<dynamic>>(
        future: api.fetchSports(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var sport = snapshot.data![index];
                var baseUrl = 'http://192.168.28.119/';
                var imageUrl = '$baseUrl${sport['image_url']}';

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BrowseAcademyScreen(
                          sportId: sport['sports_id'],
                          sportName: sport['sport_name']),
                    ));
                  },
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black45,
                      title: Text(sport['sport_name'],
                          textAlign: TextAlign.center),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
