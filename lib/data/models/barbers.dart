class Barbers {
  final String docId;
  final String barberShopName;
  final String barberName;
  final List partnersName;
  final String profilePicture;
  final String backgroundPicture;
  final String description;
  final String country;
  final String state;
  final String city;
  final String area;
  final String address;
  final String location;
  final List categories;
  final String instagram;
  final String tikTok;
  final List workSamples;
  final String employeeNumbers;
  final String phoneNumber;
  final String adBottom;

  Barbers({
    required this.docId,
    required this.barberShopName,
    required this.barberName,
    required this.partnersName,
    required this.profilePicture,
    required this.backgroundPicture,
    required this.description,
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.address,
    required this.location,
    required this.categories,
    required this.instagram,
    required this.tikTok,
    required this.workSamples,
    required this.employeeNumbers,
    required this.phoneNumber,
    required this.adBottom,
  });

  factory Barbers.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return Barbers(
      docId: documentId ?? map['DocumentId'] ?? '',
      barberShopName: map['BarberShopName'],
      barberName: map['BarberName'],
      partnersName: List.from(map['PartnersName'] ?? []),
      profilePicture: map['ProfilePicture'],
      backgroundPicture: map['BackgroundPicture'],
      description: map['Description'],
      country: map['Country'],
      state: map['State'],
      city: map['City'],
      area: map['Area'],
      address: map['Address'],
      location: map['Location'],
      categories: List.from(map['categories'] ?? []),
      instagram: map['Instagram'],
      tikTok: map['TikTok'],
      workSamples: List.from(map['WorkSamples'] ?? []),
      employeeNumbers: map['EmployeeNumbers'],
      phoneNumber: map['phoneNumber'],
      adBottom: map['AD_Banner_BarberBottom'],
    );
  }
}
