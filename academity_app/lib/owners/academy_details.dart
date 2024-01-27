import 'package:flutter/material.dart';
import 'package:academity_app/api_connection/api_service.dart';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/models/class.dart';
import 'package:academity_app/owners/widgets/classes_list.dart';

class AcademyDetails extends StatefulWidget {
  final Academy academy;

  const AcademyDetails({Key? key, required this.academy}) : super(key: key);

  @override
  _AcademyDetailsState createState() => _AcademyDetailsState();
}

class _AcademyDetailsState extends State<AcademyDetails> {
  final ApiService _apiService = ApiService();
  List<Classes> _classes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchClasses();
  }

  void _fetchClasses() async {
    try {
      var fetchedClasses = await _apiService.fetchClassesForAcademy(widget.academy.academyId);
      setState(() {
        _classes = fetchedClasses;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching classes: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.academy.name)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.academy.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Location: ${widget.academy.location}'),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _classes.length,
                      itemBuilder: (context, index) {
                        return ClassListItem(classDetail: _classes[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
