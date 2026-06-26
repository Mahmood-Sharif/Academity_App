import 'package:academity_app/models/academy.dart';
import 'package:academity_app/models/sport.dart';

class DemoData {
  static final sports = <Sport>[
    Sport(sportsId: 1, sportName: 'Basketball', imageUrl: ''),
    Sport(sportsId: 2, sportName: 'Football', imageUrl: ''),
    Sport(sportsId: 3, sportName: 'Boxing', imageUrl: ''),
    Sport(sportsId: 4, sportName: 'Taekwondo', imageUrl: ''),
    Sport(sportsId: 5, sportName: 'Fencing', imageUrl: ''),
    Sport(sportsId: 6, sportName: 'Padel', imageUrl: ''),
  ];

  static List<Academy> academiesForSport(int sportId) {
    final sport = sports.firstWhere(
      (item) => item.sportsId == sportId,
      orElse: () => sports.first,
    );

    return [
      Academy(
        academyId: 1000 + sportId,
        location: 'Seef District, Bahrain',
        name: '${sport.sportName} Performance Hub',
        phone: '+973 1700 0000',
        description:
            'A curated academy experience with professional coaches, flexible class schedules, and progress tracking for young athletes.',
        imageUrl: '',
      ),
      Academy(
        academyId: 2000 + sportId,
        location: 'Riffa Sports Village',
        name: '${sport.sportName} Junior Academy',
        phone: '+973 1700 1111',
        description:
            'Beginner-friendly sessions designed around confidence, skill development, and consistent attendance.',
        imageUrl: '',
      ),
    ];
  }
}
