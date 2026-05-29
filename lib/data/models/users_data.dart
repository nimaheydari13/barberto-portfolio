class Users {
  final String name;
  final String email;
  final String profileImage; // now always a string (filename)
  final String phoneNumber;
  final String state; // Added state field
  final String city;
  final String area; // Added area field
  final bool gender;

  Users({
    required this.name,
    required this.email,
    required this.profileImage,
    required this.phoneNumber,
    required this.state,
    required this.city,
    required this.area,
    required this.gender,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map['name'],
      email: map['email'],
      profileImage:
          map['profileImage'] ?? 'profile_girl.png', // default to filename
      phoneNumber: map['phoneNumber'] ?? '',
      state: map['state'] ?? 'تهران', // default state
      city: map['city'] ?? 'تهران', // default city
      area: map['area'] ?? '', // default area
      gender: map['gender'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profileImage': profileImage, // always a filename string
      'phoneNumber': phoneNumber,
      'state': state,
      'city': city,
      'area': area,
      'gender': gender,
    };
  }
}
