import '../models/user_card_model.dart';

class DummyUsers {
  static final List<UserCardModel> users = [
    UserCardModel(
      id: '1',
      name: 'Olivia Otta',
      age: 25,
      location: 'New York, USA',
      bio: 'Adventure seeker | Coffee enthusiast | Travel lover',
      photos: [
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800',
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800',
      ],
      interests: ['Travel', 'Photography', 'Coffee', 'Hiking'],
      distance: '2 miles away',
    ),
    UserCardModel(
      id: '2',
      name: 'Emma Johnson',
      age: 23,
      location: 'Los Angeles, USA',
      bio: 'Artist | Yoga instructor | Plant mom',
      photos: [
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800',
        'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=800',
        'https://images.unsplash.com/photo-1506863530036-1efeddceb993?w=800',
      ],
      interests: ['Yoga', 'Art', 'Music', 'Nature'],
      distance: '5 miles away',
    ),
    UserCardModel(
      id: '3',
      name: 'Sophia Martinez',
      age: 27,
      location: 'Miami, USA',
      bio: 'Beach lover | Foodie | Dancing queen',
      photos: [
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=800',
        'https://images.unsplash.com/photo-1509967419530-da38b4704bc6?w=800',
        'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=800',
      ],
      interests: ['Dancing', 'Food', 'Beach', 'Salsa'],
      distance: '3 miles away',
    ),
    UserCardModel(
      id: '4',
      name: 'Ava Williams',
      age: 24,
      location: 'Chicago, USA',
      bio: 'Bookworm | Cat lover | Netflix addict',
      photos: [
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
        'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=800',
        'https://images.unsplash.com/photo-1496440737103-cd596325d314?w=800',
      ],
      interests: ['Reading', 'Movies', 'Cats', 'Writing'],
      distance: '4 miles away',
    ),
    UserCardModel(
      id: '5',
      name: 'Isabella Davis',
      age: 26,
      location: 'Seattle, USA',
      bio: 'Tech enthusiast | Runner | Dog mom',
      photos: [
        'https://images.unsplash.com/photo-1524250502761-1ac6f2e30d43?w=800',
        'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=800',
        'https://images.unsplash.com/photo-1513956589380-bad6acb9b9d4?w=800',
      ],
      interests: ['Technology', 'Running', 'Dogs', 'Gaming'],
      distance: '1 mile away',
    ),
    UserCardModel(
      id: '6',
      name: 'Mia Anderson',
      age: 22,
      location: 'Austin, USA',
      bio: 'Music festival lover | Photographer | Free spirit',
      photos: [
        'https://images.unsplash.com/photo-1517365830460-955ce3ccd263?w=800',
        'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?w=800',
        'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=800',
      ],
      interests: ['Music', 'Photography', 'Festivals', 'Art'],
      distance: '6 miles away',
    ),
    UserCardModel(
      id: '7',
      name: 'Charlotte Brown',
      age: 28,
      location: 'Boston, USA',
      bio: 'Fitness coach | Health nut | Motivational speaker',
      photos: [
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=800',
        'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?w=800',
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?w=800',
      ],
      interests: ['Fitness', 'Health', 'Motivation', 'Gym'],
      distance: '7 miles away',
    ),
    UserCardModel(
      id: '8',
      name: 'Amelia Wilson',
      age: 25,
      location: 'San Francisco, USA',
      bio: 'Startup founder | Wine enthusiast | World traveler',
      photos: [
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800',
        'https://images.unsplash.com/photo-1504593811423-6dd665756598?w=800',
        'https://images.unsplash.com/photo-1525134479668-1bee5c7c6845?w=800',
      ],
      interests: ['Business', 'Wine', 'Travel', 'Innovation'],
      distance: '3 miles away',
    ),
  ];

  static List<UserCardModel> getUsers() {
    return users;
  }

  static UserCardModel? getUserById(String id) {
    try {
      return users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
}
