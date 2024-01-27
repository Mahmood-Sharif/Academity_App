import 'package:academity_app/models/academy.dart';
import 'package:academity_app/owners/widgets/academy_list.dart';
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

