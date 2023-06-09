class AddressModel {
  double latitude, longitude;
  DateTime timestamp;
  String name, countryCode, street, postalcode, state, locality;
  AddressModel({
    required this.name,
    required this.locality,
    required this.countryCode,
    required this.state,
    required this.street,
    required this.postalcode,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp,
        'name': name,
        'countryCode': countryCode,
        'state': state,
        'street': street,
        'postalcode': postalcode,
        'locality': locality,
      };
  static AddressModel fromMap(dynamic userMap) {
    return AddressModel(
      name: userMap['name'],
      countryCode: userMap['countryCode'],
      state: userMap['state'],
      street: userMap['street'],
      postalcode: userMap['postalcode'],
      locality: userMap['locality'],
      latitude: userMap['latitude'],
      longitude: userMap['longitude'],
      timestamp: userMap['timestamp'],
    );
  }
}
