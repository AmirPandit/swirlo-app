class UserCardModel {
  final String id;
  final String name;
  final int age;
  final String location;
  final String bio;
  final List<String> photos;
  final List<String> interests;
  final String distance;

  UserCardModel({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.bio,
    required this.photos,
    required this.interests,
    required this.distance,
  });
}
