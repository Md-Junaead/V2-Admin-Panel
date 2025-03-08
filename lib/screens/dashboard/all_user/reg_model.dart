import 'dart:convert';

class UserRegistration {
  final int id;
  final String userid;
  final String name;
  final String email;
  final String password;
  final String? phoneNo;
  final String? address;
  final String country;
  final DateTime? dob;
  final String referralCode;
  final String? nidnumber;
  final String? passport;
  final bool active;
  final String role;
  final bool enabled;
  final String username;
  final List<String> authorities;
  final bool lock;
  final bool accountNonLocked;
  final bool accountNonExpired;
  final bool credentialsNonExpired;

  UserRegistration({
    required this.id,
    required this.userid,
    required this.name,
    required this.email,
    required this.password,
    this.phoneNo,
    this.address,
    required this.country,
    this.dob,
    required this.referralCode,
    this.nidnumber,
    this.passport,
    required this.active,
    required this.role,
    required this.enabled,
    required this.username,
    required this.authorities,
    required this.lock,
    required this.accountNonLocked,
    required this.accountNonExpired,
    required this.credentialsNonExpired,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      id: json['id'],
      userid: json['userid'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNo: json['phoneNo'],
      address: json['address'],
      country: json['country'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      referralCode: json['referralCode'],
      nidnumber: json['nidnumber'],
      passport: json['passport'],
      active: json['active'],
      role: json['role'],
      enabled: json['enabled'],
      username: json['username'],
      authorities: (json['authorities'] as List)
          .map((auth) => auth['authority'] as String)
          .toList(),
      lock: json['lock'],
      accountNonLocked: json['accountNonLocked'],
      accountNonExpired: json['accountNonExpired'],
      credentialsNonExpired: json['credentialsNonExpired'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userid,
      'name': name,
      'email': email,
      'password': password,
      'phoneNo': phoneNo ??
          '', // Handle nullable phoneNo by assigning an empty string if null
      'address': address ?? '', // Provide a fallback for nullable address
      'country': country,
      'dob': dob?.toIso8601String(),
      'referralCode': referralCode,
      'nidnumber': nidnumber,
      'passport': passport,
      'active': active,
      'role': role,
      'enabled': enabled,
      'username': username,
      'authorities': authorities.map((auth) => {'authority': auth}).toList(),
      'lock': lock,
      'accountNonLocked': accountNonLocked,
      'accountNonExpired': accountNonExpired,
      'credentialsNonExpired': credentialsNonExpired,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

// class RegUserModel {
//   final int id;
//   final String userId;
//   final String name;
//   final String email;
//   final String phoneNo;
//   final String address;
//   final String country;
//   final String image;

//   RegUserModel({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.email,
//     required this.phoneNo,
//     required this.address,
//     required this.country,
//     required this.image,
//   });

//   factory RegUserModel.fromJson(Map<String, dynamic> json) {
//     return RegUserModel(
//       id: json['id'],
//       userId: json['userid'],
//       name: json['name'],
//       email: json['email'],
//       phoneNo: json['phoneNo'],
//       address: json['address'],
//       country: json['country'],
//       image: json['image'],
//     );
//   }
// }
