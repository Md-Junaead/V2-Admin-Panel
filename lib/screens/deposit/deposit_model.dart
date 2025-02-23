class DepositModel {
  final int id;
  final String userId; // Added userId as required
  final String name; // Added name
  final String country; // Added country
  final double addBalance;
  final double depositB; // Deposit balance
  final String packages;
  final double profitB; // Profit balance
  final double withdrawB; // Withdraw balance
  final UserRegistration userRegistration;

  DepositModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.country,
    required this.addBalance,
    required this.depositB,
    required this.packages,
    required this.profitB,
    required this.withdrawB,
    required this.userRegistration,
  });

  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      id: json['id'],
      userId: json['userRegistration']
          ['userid'], // Extracting userId from userRegistration
      name: json['userRegistration']
          ['name'], // Extracting name from userRegistration
      country: json['userRegistration']
          ['country'], // Extracting country from userRegistration
      addBalance: json['addBalance'].toDouble(),
      depositB: json['dipositB'].toDouble(),
      packages: json['packages'],
      profitB: json['profitB'].toDouble(),
      withdrawB: json['withdrawB'].toDouble(),
      userRegistration: UserRegistration.fromJson(json['userRegistration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userRegistration': userRegistration.toJson(),
      'addBalance': addBalance,
      'dipositB': depositB,
      'packages': packages,
      'profitB': profitB,
      'withdrawB': withdrawB,
    };
  }
}

class UserRegistration {
  final int id;
  final String userid;
  final String name;
  final String country;
  final String image;

  UserRegistration({
    required this.id,
    required this.userid,
    required this.name,
    required this.country,
    required this.image,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      id: json['id'],
      userid: json['userid'],
      name: json['name'],
      country: json['country'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userid,
      'name': name,
      'country': country,
      'image': image,
    };
  }
}
