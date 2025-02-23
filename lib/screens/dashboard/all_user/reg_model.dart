class RegUserModel {
  final int id;
  final String userId;
  final String name;
  final String email;
  final String phoneNo;
  final String address;
  final String country;
  final String image;

  RegUserModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.country,
    required this.image,
  });

  factory RegUserModel.fromJson(Map<String, dynamic> json) {
    return RegUserModel(
      id: json['id'],
      userId: json['userid'],
      name: json['name'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      address: json['address'],
      country: json['country'],
      image: json['image'],
    );
  }
}
