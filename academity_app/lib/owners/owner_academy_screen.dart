import 'package:academity_app/models/academy.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/api_connection/api_service.dart';

class OwnerAcademyScreen extends StatefulWidget {
  final int ownerId;

  const OwnerAcademyScreen({Key? key, required this.ownerId}) : super(key: key);

  @override
  _OwnerAcademyScreenState createState() => _OwnerAcademyScreenState();
}

class _OwnerAcademyScreenState extends State<OwnerAcademyScreen> {
  final ApiService _apiService = ApiService();
  List<Academy> _academies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAcademies();
  }

  void _fetchAcademies() async {
    try {
      List<Academy> academies =
          await _apiService.fetchAcademiesByOwnerId(widget.ownerId);
      print('Academies fetched: $academies'); // Debug statement
      setState(() {
        _academies = academies;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching academies: $e'); // Debug statement
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Academies"),backgroundColor: Colors.red),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _academies.length,
              itemBuilder: (context, index) {
                return AcademyListItem(
                  academy: _academies[index],
                );
              },
            ),
    );
  }
}

class AcademyListItem extends StatelessWidget {
  final Academy academy;

  const AcademyListItem({super.key, required this.academy});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0), // Adjust the radius to control the roundness
          child: SizedBox(
            width: 380.0, // Adjust the width as needed
            height: 150.0, // Adjust the height as needed
            child: Image.asset(
              'lib/images/about-slider.jpg', // Replace with your static image path
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ),
        ),
        ListTile(
          title: Text(academy.name),
          subtitle: Text(academy.location),
        ),
        const Divider(height: 20,),
      ],
    );
  }
}