class LoanModel {
  final int id;
  final double eligibleBalance;
  final double loanAmount;
  final double weeklyPay;
  final double totalPay;
  final int tenure;
  final String status;
  final String requestDate;
  final UserRegistration userRegistration;

  LoanModel({
    required this.id,
    required this.eligibleBalance,
    required this.loanAmount,
    required this.weeklyPay,
    required this.totalPay,
    required this.tenure,
    required this.status,
    required this.requestDate,
    required this.userRegistration,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      eligibleBalance: (json['eligeblebalancey'] is int
          ? (json['eligeblebalancey'] as int).toDouble()
          : json['eligeblebalancey']),
      loanAmount: (json['loanamuont'] is int
          ? (json['loanamuont'] as int).toDouble()
          : json['loanamuont']),
      weeklyPay: (json['weeklypay'] is int
          ? (json['weeklypay'] as int).toDouble()
          : json['weeklypay']),
      totalPay: (json['totalpay'] is int
          ? (json['totalpay'] as int).toDouble()
          : json['totalpay']),
      tenure: json['tenure'],
      status: json['status'],
      requestDate: json['requestdate'],
      userRegistration: UserRegistration.fromJson(json['userRegistration']),
    );
  }
}

class UserRegistration {
  final String name;
  final String email;
  final String phoneNo;

  UserRegistration({
    required this.name,
    required this.email,
    required this.phoneNo,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      name: json['name'],
      email: json['email'],
      phoneNo: json['phoneNo'],
    );
  }
}
