class BalanceModel {
  final int id;
  final double addBalance;
  final double dipositB;
  final String packages;
  final double profitB;
  final double referralB;
  final double withdrawB;
  final UserModel userRegistration;

  BalanceModel({
    required this.id,
    required this.addBalance,
    required this.dipositB,
    required this.packages,
    required this.profitB,
    required this.referralB,
    required this.withdrawB,
    required this.userRegistration,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      id: json['id'],
      addBalance: (json['addBalance'] as num).toDouble(),
      dipositB: (json['dipositB'] as num).toDouble(),
      packages: json['packages'],
      profitB: (json['profitB'] as num).toDouble(),
      referralB: (json['referralB'] as num).toDouble(),
      withdrawB: (json['withdrawB'] as num).toDouble(),
      userRegistration: UserModel.fromJson(json['userRegistration']),
    );
  }
}

class UserModel {
  final int id;
  final String userid;
  final String password;
  final String name;
  final String email;
  final String phoneNo;
  final String dob;
  final String address;
  final String country;
  final String image;
  final String referralCode;

  UserModel({
    required this.id,
    required this.userid,
    required this.password,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.dob,
    required this.address,
    required this.country,
    required this.image,
    required this.referralCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userid: json['userid'],
      password: json['password'],
      name: json['name'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      dob: json['dob'],
      address: json['address'],
      country: json['country'],
      image: json['image'],
      referralCode: json['referralCode'],
    );
  }
}
