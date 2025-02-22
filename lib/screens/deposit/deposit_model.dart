// Model: Deposit_model.dart
class DepositModel {
  final int id;
  final double addBalance;
  final double depositB;
  final String packages;
  final double profitB;
  final double referralB;
  final double withdrawB;
  final UserRegistration user;

  DepositModel({
    required this.id,
    required this.addBalance,
    required this.depositB,
    required this.packages,
    required this.profitB,
    required this.referralB,
    required this.withdrawB,
    required this.user,
  });

  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      id: json['id'],
      addBalance: json['addBalance'].toDouble(),
      depositB: json['dipositB'].toDouble(),
      packages: json['packages'],
      profitB: json['profitB'].toDouble(),
      referralB: json['referralB'].toDouble(),
      withdrawB: json['withdrawB'].toDouble(),
      user: UserRegistration.fromJson(json['userRegistration']),
    );
  }
}

class UserRegistration {
  final String name;
  final String email;
  final String phoneNo;
  final String address;
  final String country;

  UserRegistration({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.country,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      name: json['name'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      address: json['address'],
      country: json['country'],
    );
  }
}
