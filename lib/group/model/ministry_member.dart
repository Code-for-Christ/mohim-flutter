class MinistryMember {
  int id;
  String name;
  int householderId;
  String relationshipWithHouseholder;
  int? birthYear;
  int? salvationYear;
  int? salvationMonth;
  int? salvationDay;
  String? carNumber;
  String sex;
  String? phoneNumber;
  String? address;
  String? thumbnail;

  MinistryMember({
    required this.id,
    required this.name,
    required this.householderId,
    required this.relationshipWithHouseholder,
    required this.birthYear,
    required this.salvationYear,
    required this.salvationMonth,
    required this.salvationDay,
    required this.carNumber,
    required this.sex,
    required this.phoneNumber,
    required this.address,
    required this.thumbnail,
  });

  factory MinistryMember.fromJson(Map<String, dynamic> json) {
    return MinistryMember(
      id: json['id'],
      name: json['name'],
      householderId: json['householder_id'],
      relationshipWithHouseholder: json['relationship_with_householder'],
      birthYear: json['birth_year'],
      salvationYear: json['salvation_year'],
      salvationMonth: json['salvation_month'],
      salvationDay: json['salvation_day'],
      carNumber: json['car_number'],
      sex: json['sex'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      thumbnail: json['profile_image_thumbnail'],
    );
  }

  static List<MinistryMember> fromJsonList(List list) {
    return list.map((item) => MinistryMember.fromJson(item)).toList();
  }
}
