import 'package:academity_app/models/sport.dart';
import 'package:academity_app/services/sports_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Provides an instance of SportsService
final sportsServiceProvider = Provider<SportsService>((ref) {
  return SportsService();
});

// Provides the future of List<Sport>
final sportsProvider = FutureProvider<List<Sport>>((ref) async {
  return ref.read(sportsServiceProvider).fetchSports();
});
