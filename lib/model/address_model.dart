class Address {
  late String id;
  late String label;
  late String city;
  late String address;
  late String? note;
  // late String postalCode;

  Address({
    required this.id,
    required this.label,
    required this.city,
    required this.address,
    required this.note,
    // required this.postalCode,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    city = json['city'];
    address = json['address'];
    note = json['note'];
    // postalCode = json['postalCode'];
  }
}