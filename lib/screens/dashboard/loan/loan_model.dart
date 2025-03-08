class LoanModel {
  int id;
  double eligeblebalancey;
  double loanamuont;
  double weeklypay;
  double totalpay;
  int tenure;
  String status;
  String requestdate;
  UserRegistration userRegistration;
  Balance balance;

  LoanModel({
    required this.id,
    required this.eligeblebalancey,
    required this.loanamuont,
    required this.weeklypay,
    required this.totalpay,
    required this.tenure,
    required this.status,
    required this.requestdate,
    required this.userRegistration,
    required this.balance,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      eligeblebalancey: json['eligeblebalancey'].toDouble(),
      loanamuont: json['loanamuont'].toDouble(),
      weeklypay: json['weeklypay'].toDouble(),
      totalpay: json['totalpay'].toDouble(),
      tenure: json['tenure'],
      status: json['status'],
      requestdate: json['requestdate'],
      userRegistration: UserRegistration.fromJson(json['userRegistration']),
      balance: Balance.fromJson(json['balance']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eligeblebalancey': eligeblebalancey,
      'loanamuont': loanamuont,
      'weeklypay': weeklypay,
      'totalpay': totalpay,
      'tenure': tenure,
      'status': status,
      'requestdate': requestdate,
      'userRegistration': userRegistration.toJson(),
      'balance': balance.toJson(),
    };
  }
}

class UserRegistration {
  int id;
  String userid;
  String password;
  String name;
  String email;
  String phoneNo;
  String dob;
  String address;
  String country;
  String image;
  String? referralCode;

  UserRegistration({
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
    this.referralCode,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userid,
      'password': password,
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'dob': dob,
      'address': address,
      'country': country,
      'image': image,
      'referralCode': referralCode,
    };
  }
}

class Balance {
  int id;
  double addBalance;
  double dipositB;
  String packages;
  double profitB;
  double referralB;
  double withdrawB;
  UserRegistration userRegistration;

  Balance({
    required this.id,
    required this.addBalance,
    required this.dipositB,
    required this.packages,
    required this.profitB,
    required this.referralB,
    required this.withdrawB,
    required this.userRegistration,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'],
      addBalance: json['addBalance'].toDouble(),
      dipositB: json['dipositB'].toDouble(),
      packages: json['packages'],
      profitB: json['profitB'].toDouble(),
      referralB: json['referralB'].toDouble(),
      withdrawB: json['withdrawB'].toDouble(),
      userRegistration: UserRegistration.fromJson(json['userRegistration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addBalance': addBalance,
      'dipositB': dipositB,
      'packages': packages,
      'profitB': profitB,
      'referralB': referralB,
      'withdrawB': withdrawB,
      'userRegistration': userRegistration.toJson(),
    };
  }
}
